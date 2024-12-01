
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget php php-mysqli
COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh
ENTRYPOINT [ "php", "-S", "0.0.0.0:8080", "-t", "/var/www/html" ]
