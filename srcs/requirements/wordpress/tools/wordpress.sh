#!/bin/bash

mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod 755 /var/www/wordpress

cd /var/www/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root


mv wp-config-sample.php wp-config.php

sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/" wp-config.php
sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${MYSQL_USER}' );/" wp-config.php
sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/" wp-config.php
sed -i "s/localhost/${MYSQL_DATABASE}/" wp-config.php

echo "Waiting for MariaDB to be ready..."
until mysql -h "${MYSQL_DATABASE}" -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SHOW DATABASES;" &>/dev/null; do
  echo "MariaDB is not ready yet..."
  sleep 5
done


wp core install \
  --url="${DOMAIN_NAME}" \
  --title="${SITE_TITLE}" \
  --admin_user="${WP_ADMIN_USER}" \
  --admin_password="${WP_ADMIN_PASSWORD}" \
  --admin_email="${WP_ADMIN_EMAIL}" \
  --allow-root


wp user create \
    "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role=editor \
    --allow-root

wp plugin install redis-cache --activate --allow-root

wp config set WP_REDIS_HOST "${WP_REDIS_HOST}" --add --allow-root
wp config set WP_REDIS_PASSWORD "${WP_REDIS_PASSWORD}" --add --allow-root
wp config set WP_REDIS_PORT "${WP_REDIS_PORT}" --add --allow-root
wp config set WP_CACHE true --add --allow-root
wp config set WP_REDIS_DATABASE 0 --add --allow-root
wp config set WP_REDIS_CACHE_PATH ${WP_REDIS_CACHE_PATH} --add --allow-root

wp redis enable --allow-root

mkdir -p /run/php

php-fpm7.4 -F
