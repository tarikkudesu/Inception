
FROM debian:bookworm
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx openssl
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx.sh /nginx.sh
RUN chmod +x /nginx.sh && /nginx.sh
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
