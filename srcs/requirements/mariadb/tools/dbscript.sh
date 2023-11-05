#!/bin/bash

# Démarre le service MariaDB.
service mariadb start;

# Pause d'une seconde pour assurer que MariaDB a démarré.
sleep 1

# Crée une base de données MySQL si elle n'existe pas déjà.
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Crée un utilisateur MySQL s'il n'existe pas déjà.
mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Accorde tous les privilèges à l'utilisateur sur la base de données.
mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modifie le mot de passe de l'utilisateur 'root' de MySQL.
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Actualise les privilèges pour prendre en compte les modifications.
mariadb -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Arrête proprement le service MariaDB.
mysqladmin -u root --password=${SQL_ROOT_PASSWORD} shutdown

# Démarre MariaDB en mode sécurisé (safe mode).
mysqld_safe
