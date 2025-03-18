FROM debian:buster

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    redis-server
RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf
CMD [ "redis-server", "/etc/redis/redis.conf" ]