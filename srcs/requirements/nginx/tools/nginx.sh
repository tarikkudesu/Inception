#!/bin/bash

mkdir -p /var/www/html && mkdir -p /etc/nginx/ssl

chown -R www-data:www-data /var/www/html

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=MO/ST=KH/O=42/OU=42/CN=tamehri.42.fr/UID=tarikku_desu"
