#!/bin/bash

# Start the MySQL daemon
mysqld &

# Wait for the MySQL server to start (you can adjust the sleep time as needed)
sleep 10

# Set the root password for MariaDB
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

# Create a new database for WordPress (you can change the database name if needed)
MYSQL_DATABASE=${MYSQL_DATABASE}
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

# Create a new user for WordPress and grant necessary privileges
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"

# Flush privileges and stop the MySQL daemon
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
