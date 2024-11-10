
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx openssl vim
RUN mkdir -p /var/www/html
COPY ./tools/website /var/www/html
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/setup.sh /
RUN chmod +x /setup.sh
ENTRYPOINT [ "/setup.sh" ]
