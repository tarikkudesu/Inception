#!/bin/bash

cat <<EOF > /etc/nginx/nginx.conf
events {}
http {
    include /etc/nginx/mime.types;

    server {
        listen 1200 ssl;
        root /var/www/html;
        server_name ${INCEPTION_LOGIN}.42.fr;
        index index.html;

        ssl_certificate /etc/nginx/ssl/inception.crt;
        ssl_certificate_key /etc/nginx/ssl/inception.key;
        ssl_protocols TLSv1.2 TLSv1.3;
    }
}
EOF

mkdir -p /etc/nginx/ssl
chown -R www-data:www-data /var/www/html
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=MO/ST=KH/O=42/OU=42/CN=${INCEPTION_LOGIN}.42.fr"
nginx -g "daemon off;"
