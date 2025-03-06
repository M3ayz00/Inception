#!/bin/bash

mkdir -p /var/www/wordpress
cd /var/www/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

mv wp-config-sample.php wp-config.php

sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/" wp-config.php
sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${MYSQL_USER}' );/" wp-config.php
sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php

echo "Waiting for MariaDB to be ready..."
until mysql -h mariadb -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SHOW DATABASES;" &>/dev/null; do
    echo "MariaDB is not ready yet..."
    sleep 2
done

wp core install \
  --url="${DOMAIN_NAME}" \
  --admin_user="${WP_ADMIN_USER}" \
  --admin_password="${WP_ADMIN_PASSWORD}" \
  --allow-root

wp user create \
    "${WP_USER}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role=editor \
    --allow-root

mkdir -p /run/php

php-fpm7.4 -F
