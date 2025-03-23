#!/bin/bash

echo "Starting MariaDB..."
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --data-dir=/var/lib/mysql
fi

mysqld_safe --datadir=/var/lib/mysql &

echo "Waiting for MariaDB to start..."
while ! mysqladmin ping --silent; do
    sleep 1
done

echo "Setting up database users..."
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

echo "Shutting down MariaDB..."
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "Restarting MariaDB in foreground mode..."
exec mysqld_safe --datadir=/var/lib/mysql
