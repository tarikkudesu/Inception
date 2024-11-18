#!/bin/bash

rm -rf /home/backup/wordpress/*
mkdir -p /home/backup/wordpress /home/backup/database
rsync -a /var/www/html/ /home/backup/wordpress/
mysqldump -h mariadb -P 3306 \
    -u ${INCEPTION_MYSQL_USER} \
    -p${INCEPTION_MYSQL_PASS} \
    ${INCEPTION_MYSQL_DATABASE} > /home/backup/database/db_backup.sql
