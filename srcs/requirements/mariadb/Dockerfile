FROM debian:bullseye

RUN apt-get update \
	&& apt-get install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d
COPY ./conf/mariadb.sql /
COPY ./tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["script.sh"]

WORKDIR /usr

EXPOSE 3306

CMD ["mysqld_safe", "--datadir=/var/lib/mysql"]