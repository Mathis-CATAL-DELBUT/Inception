# Utilisation de l'image de base Debian Bullseye
FROM debian:bullseye

# Met à jour le système d'exploitation
RUN apt update && apt upgrade -y

# Installe les packages nécessaires, dont PHP, PHP-FPM, PHP-MySQL, MariaDB client et sudo
RUN apt install wget php7.4 php-fpm php-mysql mariadb-client sudo -y

# Télécharge et extrait WordPress depuis le site officiel
RUN wget https://fr.wordpress.org/wordpress-6.2.2-fr_FR.tar.gz -P /var/www/html

# Décompresse l'archive de WordPress et supprime l'archive
RUN cd /var/www/html && tar -xzf /var/www/html/wordpress-6.2.2-fr_FR.tar.gz && rm /var/www/html/wordpress-6.2.2-fr_FR.tar.gz

# Modifie les propriétaires et groupes des fichiers dans /var/www/ pour www-data
RUN chown -R www-data:www-data /var/www/*

# Ajuste les autorisations de fichiers pour /var/www/
RUN chmod -R 755 /var/www/*

# Copie le fichier de configuration "www.conf" pour PHP-FPM
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Télécharge WP-CLI, un outil en ligne de commande pour WordPress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Donne des autorisations d'exécution à WP-CLI
RUN chmod +x wp-cli.phar

# Déplace WP-CLI vers /usr/local/bin/wp
RUN mv wp-cli.phar /usr/local/bin/wp

# Copie le script "wpscript.sh" local dans le conteneur
COPY ./tools/wpscript.sh ./

# Donne des autorisations d'exécution au script
RUN chmod +x ./wpscript.sh

# Expose le port 9000 pour PHP-FPM
EXPOSE 9000

# Définit le point d'entrée du conteneur pour exécuter le script "wpscript.sh" avec Bash
ENTRYPOINT ["bash", "./wpscript.sh"]
