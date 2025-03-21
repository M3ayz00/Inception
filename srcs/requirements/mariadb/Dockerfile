FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /tmp

RUN chmod +x /tmp/mariadb.sh

CMD ["/tmp/mariadb.sh"]