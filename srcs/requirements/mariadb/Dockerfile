
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server vim
COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh
ENTRYPOINT [ "/setup.sh" ]
