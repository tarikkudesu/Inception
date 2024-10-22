
FROM debian:bookworm
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y mariadb-server
COPY ./tools/mdb-conf.sh /mdb-conf.sh
RUN chmod +x /mdb-conf.sh
ENTRYPOINT [ "/mdb-conf.sh" ]
