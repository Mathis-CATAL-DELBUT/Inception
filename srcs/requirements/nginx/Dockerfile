FROM debian:buster

RUN apt-get update -y \
    && apt-get install -y nginx\
    && apt-get install -y vim\
    && apt-get install -y curl\
    && mkdir -p /etc/nginx/ssl\
    && apt-get install -y openssl\
    && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mathiflix.me/UID=mcatal-d"\
    && mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html\
    &&chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
