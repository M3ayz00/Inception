FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    chmod 777 /var/run/mysqld

COPY tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

CMD ["mariadb.sh"]