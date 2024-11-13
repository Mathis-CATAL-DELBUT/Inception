FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y wget php7.4 php-fpm php-mysql mariadb-client sudo \
    && wget https://fr.wordpress.org/wordpress-6.2.2-fr_FR.tar.gz -P /var/www/html \
    && tar -xzf /var/www/html/wordpress-6.2.2-fr_FR.tar.gz -C /var/www/html \
    && rm /var/www/html/wordpress-6.2.2-fr_FR.tar.gz \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wpscript.sh ./

RUN chmod +x ./wpscript.sh

EXPOSE 9000

ENTRYPOINT ["bash", "./wpscript.sh"]
