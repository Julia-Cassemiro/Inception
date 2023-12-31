FROM debian:bullseye

# argumentos das variáveis de ambiente
# ARG MYSQL_HOST
# ARG MYSQL_DATABASE
# ARG MYSQL_USER
# ARG MYSQL_PASSWORD

# Instala as dependências
RUN apt-get update && apt-get install -y \
	php \
	php-fpm \
	php-mysql \
	php-gd \
	php-opcache \
	php-cli \
	php-curl \
	php-mbstring \
	wget \
	unzip

# Faz o download e extrai a última versão do WordPress
RUN wget -P /tmp https://wordpress.org/latest.zip \
	&& unzip /tmp/latest.zip -d /var/www/ \
	&& rm /tmp/latest.zip

# Copia a file .conf para o diretório html
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/  
# ou /etc/php/7.3/fpm/pool.d/ dependendo da versão do PHP

# Seta o ownership e permissões para as files do WordPress
RUN chown -R www-data:www-data /var/www/wordpress \
	&& chmod -R 777 /var/www/wordpress

# Cria a pasta para que o php possa rodar
RUN mkdir /run/php

# Seta o diretório html como workdir
WORKDIR /var/www/wordpress/

RUN sed -i 's/listen\s*=\s*.*/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf   # ou /etc/php/7.3/fpm/pool.d/ dependendo da versão do PHP

# Configura o wordpress copiando alguns arquivos e alterando as variaveis do banco de dados no arquivo wp-config (linhas 47 a 50)
# RUN cp wp-config-sample.php wp-config.php && \
# 	sleep 5s && \
# 	mv wp-config-sample.php /var/www/wordpress/wp-config.php && \
# 	sed -i "s/username_here/$MYSQL_USER/g" /var/www/wordpress/wp-config.php && \
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/wordpress/wp-config.php && \
# 	sed -i "s/localhost/$MYSQL_HOST/g" /var/www/wordpress/wp-config.php && \
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/wordpress/wp-config.php && \
# 	chown -R www-data:www-data /var/www/wordpress

# Abre a porta 9000 para o php-fpm
EXPOSE 9000

# Inicia php-fpm
CMD ["php-fpm7.4", "-F"]   # ou php-fpm7.3 dependendo da versão do PHP
