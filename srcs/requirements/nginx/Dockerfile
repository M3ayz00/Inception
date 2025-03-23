FROM debian:bullseye

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    nginx \
    openssl
RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY tools/nginx.sh /tmp/nginx.sh

RUN chmod +x /tmp/nginx.sh

CMD [ "/tmp/nginx.sh" ]