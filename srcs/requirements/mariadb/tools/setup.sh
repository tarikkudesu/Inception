#!/bin/bash

service mariadb start
mariadb -e "CREATE DATABASE IF NOT EXISTS ${INCEPTION_MYSQL_DATABASE}"
mariadb -e "CREATE USER IF NOT EXISTS '${INCEPTION_MYSQL_USER}'@'%' IDENTIFIED BY '${INCEPTION_MYSQL_PASS}'"
mariadb -e "GRANT ALL ON ${INCEPTION_MYSQL_DATABASE}.* TO '${INCEPTION_MYSQL_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -u root
mysqld --bind-address=0.0.0.0 --port=3306 --user=root
