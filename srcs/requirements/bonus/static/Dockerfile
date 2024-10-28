
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx vim
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html
COPY ./tools/website .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
