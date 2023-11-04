FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install wget php7.4 php-fpm php-mysql mariadb-client sudo -y

RUN wget https://fr.wordpress.org/wordpress-6.2.2-fr_FR.tar.gz -P /var/www/html

RUN cd /var/www/html && tar -xzf /var/www/html/wordpress-6.2.2-fr_FR.tar.gz && rm /var/www/html/wordpress-6.2.2-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/*

RUN chmod -R 755 /var/www/*

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/wpscript.sh ./

RUN chmod +x ./wpscript.sh

EXPOSE 9000

ENTRYPOINT ["bash", "./wpscript.sh"]
