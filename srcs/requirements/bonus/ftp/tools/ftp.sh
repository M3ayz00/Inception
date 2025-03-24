#!/bin/bash

mkdir -p /var/www/wordpress /var/run/vsftpd/empty
useradd -d /var/www/wordpress ${FTP_USER} && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd

chown -R ${FTP_USER}:www-data /var/www/wordpress
chmod -R 775 /var/www/wordpress

exec /usr/sbin/vsftpd /etc/vsftpd.conf