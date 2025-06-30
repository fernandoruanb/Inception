FROM debian:bullseye
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-client netcat iputils-ping php-fpm php7.4-mysqli curl vim
RUN rm -rf /var/www/html && mkdir /run/php && chown -R www-data:www-data /run/php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/.
COPY ./tools/wp-install.sh .
RUN chmod +x wp-install.sh
ENTRYPOINT [ "/wp-install.sh" ]
