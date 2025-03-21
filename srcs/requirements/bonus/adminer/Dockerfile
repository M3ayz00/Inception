FROM debian:buster

RUN apt update -y && apt upgrade -y && \
    apt install -y curl php php-cli php-mysql

RUN mkdir -p /var/www/adminer

RUN curl -L -o /var/www/adminer/index.php https://adminer.org/latest.php

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]
