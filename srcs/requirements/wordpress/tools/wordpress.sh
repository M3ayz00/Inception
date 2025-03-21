#!/bin/bash

mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod 755 /var/www/wordpress

cd /var/www/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp config create \
  --allow-root \
  --dbname=${WORDPRESS_DB_NAME} \
  --dbuser=${WORDPRESS_DB_USER} \
  --dbpass=${WORDPRESS_DB_PASSWORD} \
  --dbhost=${WORDPRESS_DB_HOST}

echo "Waiting for MariaDB to be ready..."
until mysql -h "${WORDPRESS_DB_HOST}" -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SHOW DATABASES;" &>/dev/null; do
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
    --role=author \
    --allow-root

wp plugin install redis-cache --activate --allow-root

wp config set FS_METHOD direct --add --allow-root
wp config set WP_REDIS_HOST "${WP_REDIS_HOST}" --add --allow-root
wp config set WP_REDIS_PORT "${WP_REDIS_PORT}" --add --allow-root
wp config set WP_CACHE true --add --allow-root

wp redis enable --allow-root

mkdir -p /run/php

php-fpm7.4 -F
