#!/bin/bash

mv /var/www/html /tmp/wp-full
mkdir -p /var/www/html
cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
./wp-cli.phar core download --allow-root

until ping -c 1 mariadb > /dev/null 2>&1;
do
	echo "Waiting for mariadb answering on the web"
	sleep 1
done

WORDPRESS_DB_NAME=$(cat "/run/secrets/wp_database")
WORDPRESS_DB_USER=$(cat "/run/secrets/wp_user")
WORDPRESS_DB_PASS=$(cat "/run/secrets/wp_pass")
WORDPRESS_DB_HOST=$(cat "/run/secrets/wp_host")
WORDPRESS_URL=$(cat "/run/secrets/wp_url")
WORDPRESS_TITLE=$(cat "/run/secrets/wp_title")
WORDPRESS_ADMIN_USER=$(cat "/run/secrets/wp_admin_user")
WORDPRESS_ADMIN_PASSWORD=$(cat "/run/secrets/wp_admin_pass")
WORDPRESS_ADMIN_EMAIL=$(cat "/run/secrets/wp_admin_email")

./wp-cli.phar config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASS" --dbhost="$WORDPRESS_DB_HOST" --allow-root
./wp-cli.phar core install --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --allow-root

for var in $(env | grep WORDPRESS | cut -d '=' -f 1); do unset $var; done

mv /tmp/wp-full /var/www/html

#rm -rf /run/secrets

chmod 600 /run/secrets

php-fpm7.4 -F
