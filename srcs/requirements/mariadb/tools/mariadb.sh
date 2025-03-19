#!/bin/bash

pkill -9 mysqld || true
sleep 5

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --skip-networking --user=mysql &
PID=$!

until mysqladmin ping >/dev/null 2>&1; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

mysql <<EOF
-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Create application user
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Create root user with remote access
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

kill $PID
wait $PID

echo "MariaDB initialization completed successfully!"

exec mysqld --user=mysql