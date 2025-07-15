#!/bin/bash

mysqld_safe --skip-networking &
pid="$!"

until mysqladmin ping --silent;
do
	echo "waiting mariadb starts"
	sleep 1
done

MYSQL_USER=$(cat "/run/secrets/mysql_user")
MYSQL_DATABASE=$(cat "/run/secrets/mysql_database")
MYSQL_HOST=$(cat "/run/secrets/mysql_host")
MYSQL_PASSWORD=$(cat "/run/secrets/mysql_pass")
MYSQL_PRIVILEGES=$(cat "/run/secrets/mysql_privileges")
MYSQL_ROOT_PASSWORD=$(cat "/run/secrets/db_root_password")
ROOT_USER=$(cat "/run/secrets/root_user")
ROOT_HOST=$(cat "/run/secrets/root_host")

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > /tmp/init.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'$MYSQL_HOST' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /tmp/init.sql;
echo "GRANT ALL PRIVILEGES ON $MYSQL_PRIVILEGES TO '$MYSQL_USER'@'$MYSQL_HOST';" >> /tmp/init.sql
echo "ALTER USER '$ROOT_USER'@'$ROOT_HOST'" >> /tmp/init.sql

echo "FLUSH PRIVILEGES;" >> /tmp/init.sql

mysql -u root < /tmp/init.sql

rm -f /tmp/init.sql

mysqladmin shutdown

wait "$pid"

chmod 600 /run/secrets

exec mysqld_safe
