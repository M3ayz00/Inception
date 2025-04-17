FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y \
    curl \
    php \
    php-cli \
    php-mysql
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer

RUN curl -L -o /var/www/adminer/index.php https://adminer.org/latest.php

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]
