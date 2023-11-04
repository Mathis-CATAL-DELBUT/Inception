#!/bin/bash

# crée le répertoire "/run/php" si n'existe pas.
if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
fi

sleep 10

# aller ou répertoire où WordPress est installé.
cd /var/www/html/wordpress

# Vérifie si WordPress n'est pas déjà installé.
if ! wp core is-installed --allow-root; then

    # Si WordPress n'est pas encore installé, configure la base de données WordPress.
    wp config create --allow-root \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=${SQL_HOST} \
        --path='/var/www/html/wordpress/';

    # Installe WordPress avec les paramètres spécifiés.
    wp core install --allow-root \
        --url=https://${DOMAIN_NAME} \
        --title=${SITE_TITLE} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL};

    # Crée un nouvel utilisateur dans WordPress.
    wp user create --allow-root \
        ${USER1_LOGIN} ${USER1_EMAIL} \
        --user_pass=${USER1_PASS};

    # Vide le cache de WordPress.
    wp cache flush --allow-root

fi

# Exécute le serveur PHP-FPM.
exec /usr/sbin/php-fpm7.4 -F -R
