
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx vim
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
COPY ./tools/website .
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
