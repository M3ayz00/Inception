FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y \
    mariadb-server 
RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /tmp

RUN chmod +x /tmp/mariadb.sh

CMD ["/tmp/mariadb.sh"]