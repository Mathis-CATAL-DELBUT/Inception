# Image docker de base 
FROM debian:buster

# installe NGINX et ses dependences
RUN apt-get update -y 
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl

# create a directory to store certificates and keys and generate the keys
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mcatal-d.42.fr/UID=mcatal-d"
# openssl = chiffrement et sécurité des communications.
# req -x509 = creer un certificat x509 auto signe (il n'a donc pas vraiment de valeur)
# nodes = pas de chiffrement 
# copy the provided config file to the container
# -subj = info du contrat : C -> pays / ST -> region / L -> Localisation / O -> organisation / OU -> unite oranisationnelle / CM -> nom commun / UID -> identifiant unique 
RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
# +rx
RUN chown -R www-data:www-data /var/www/html
# change la propriete de /var/www/html. Garanti l'acces et le service par nginx (Wordpress par exemple)

CMD ["nginx", "-g", "daemon off;"]
# -g spécifier une directive de configuration qui doit être exécutée au démarrage du serveur.
# -g daemon off; sert a run le container temps que nginx run 
