FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y \
    mariadb-server
RUN apt clean && rm -rf /var/lib/apt/lists/*


COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# RUN mkdir -p /run/mysqld/ && \
#     chown -R mysql:mysql /run/mysqld/ &&\
#     chmod 777 /run/mysqld/

ENTRYPOINT ["/entrypoint.sh"]