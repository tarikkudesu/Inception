
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx
COPY ./tools/website /var/www/html
COPY ./tools/setup.sh /
RUN chmod +x /setup.sh && /setup.sh
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
