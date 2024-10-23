#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
chmod -R 755 /var/www/html/
chown -R www-data:www-data /var/www/html

wp core download --allow-root
touch wp-config.php
cp wp-config-sample.php wp-config.php

sed -i 's/database_name_here/'${MYSQL_DATABASE}'/' /var/www/html/wp-config.php
sed -i 's/username_here/'${MYSQL_USER}'/' /var/www/html/wp-config.php
sed -i 's/password_here/'${MYSQL_PASSWORD}'/' /var/www/html/wp-config.php
sed -i 's/localhost/mariadb:3300/' /var/www/html/wp-config.php

wp core install --url=$DOMAIN_NAME --title="My Wordpress Site" --admin_user=$WP_ADMIN_N --admin_password=$WP_ADMIN_P --admin_email=$WP_ADMIN_E --allow-root
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root

wp theme install ${WP_THEME}  --activate --allow-root

sed -i '36 s/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
