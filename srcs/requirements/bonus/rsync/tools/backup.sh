#!/bin/bash

rm -rf /home/backup/wordpress/*
mkdir -p /home/backup/wordpress /home/backup/database
rsync -a /var/www/html/ /home/backup/wordpress/
mysqldump -h mariadb -P 3306 -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > /home/backup/database/db_backup.sql
