#!/bin/bash

# create ssl directory to store the ssl private key and the ssl certificate
mkdir -p /var/www/html && mkdir -p /etc/nginx/ssl
echo "created /etc/nginx/ssl"
# give the ownership of the website files directory to www-data
chown -R www-data:www-data /var/www/html
echo "gave the ownership of the website files directory to www-data"
# generate a private key and create a self signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=MO/ST=KH/O=42/OU=42/CN=tamehri.42.fr/UID=tarikku_desu"
echo "created the self signed certificate"
