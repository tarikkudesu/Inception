
FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y redis-server
COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh
ENTRYPOINT [ "redis-server", "--protected-mode", "no" ]
