#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
chmod -R 755 /var/www/html
sed -i '36 s/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf

wait_for_mariadb() {
    until mariadb -h mariadb -P 3306 -u "${INCEPTION_MYSQL_USER}" -p"${INCEPTION_MYSQL_PASS}" -e "SELECT 1"; do
        sleep 2
    done
}
wait_for_mariadb

wp core download --allow-root
wp config create \
	--dbname=${INCEPTION_MYSQL_DATABASE} \
	--dbuser=${INCEPTION_MYSQL_USER} \
	--dbpass=${INCEPTION_MYSQL_PASS} \
	--dbhost=mariadb:3306 --allow-root
wp core install \
	--url=${INCEPTION_DOMAIN_NAME} \
	--title=${INCEPTION_WP_TITLE} \
	--admin_user=${INCEPTION_WP_A_NAME} \
	--admin_password=${INCEPTION_WP_A_PASS} \
	--admin_email=${INCEPTION_WP_A_EMAIL} --allow-root
wp user create ${INCEPTION_WP_U_NAME} ${INCEPTION_WP_U_EMAIL} \
	--user_pass=${INCEPTION_WP_U_PASS} \
	--role=${INCEPTION_WP_U_ROLE} --allow-root

wp config set WP_CACHE 'true' --allow-root
wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp redis enable --allow-root

chown -R www-data:www-data /var/www/html

mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
