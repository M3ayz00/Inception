#!/bin/bash

echo "Starting MariaDB..."

# Initialize the database if it has not been initialized already
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --data-dir=/var/lib/mysql
fi

# Start MariaDB in the background
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
while ! mysqladmin ping --silent; do
    sleep 1
done

echo "Setting up database users..."
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Shutting down MariaDB..."
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "Restarting MariaDB in foreground mode..."
exec mysqld_safe --datadir=/var/lib/mysql
