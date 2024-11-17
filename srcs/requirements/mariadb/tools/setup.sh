#!/bin/bash

service mariadb start
sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
mariadb -e "CREATE DATABASE IF NOT EXISTS ${INCEPTION_MYSQL_DATABASE}"
mariadb -e "CREATE USER IF NOT EXISTS '${INCEPTION_MYSQL_USER}'@'%' IDENTIFIED BY '${INCEPTION_MYSQL_PASS}'"
mariadb -e "GRANT ALL ON ${INCEPTION_MYSQL_DATABASE}.* TO '${INCEPTION_MYSQL_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mysqladmin -u root shutdown
mysqld --port=3306 --user=root
