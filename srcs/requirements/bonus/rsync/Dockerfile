
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y cron rsync mariadb-client
COPY ./tools/setup.sh /setup.sh
COPY ./tools/backup.sh /backup.sh
RUN chmod +x /setup.sh && chmod +x /backup.sh
ENTRYPOINT [ "/setup.sh" ]
