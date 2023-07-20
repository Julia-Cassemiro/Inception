FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx \
	    openssl

#nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/jgomes-c.crt \
       -keyout /etc/nginx/ssl/jgomes-c.key \
       -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42 School/OU=jgomes-c/CN=jgomes-c/"

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

# Copia os arquivos dos sites para a pasta
COPY ./tools/* /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
