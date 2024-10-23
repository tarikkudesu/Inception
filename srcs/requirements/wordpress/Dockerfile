
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y curl php php-mysql php7.4-fpm mariadb-client vim
COPY ./tools/wp_conf.sh /
RUN chmod +x /wp_conf.sh
ENTRYPOINT [ "/wp_conf.sh" ]
