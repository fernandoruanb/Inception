FROM debian:bullseye
RUN apt-get update && apt-get install -y gettext mariadb-server
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY ./tools/start.sh .
RUN mkdir -p /run/mysqld && chmod +x start.sh
ENTRYPOINT [ "/start.sh" ]
