#!/bin/bash

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes \
    -days 365 \
    -keyout ${CERT_KEY} \
    -out ${CERT} \
    -subj "/CN=${DOMAIN_NAME}"

mkdir -p /var/www/wordpress /var/run/nginx 
chmod 755 /var/www/wordpress 
chown -R www-data:www-data /var/www/wordpress

sed -i \
  -e "s|__CERT__|${CERT}|g" \
  -e "s|__CERT_KEY__|${CERT_KEY}|g" \
  -e "s|__DOMAIN_NAME__|${DOMAIN_NAME}|g" \
  /etc/nginx/nginx.conf.template

mv /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf

exec nginx -g "daemon off;"