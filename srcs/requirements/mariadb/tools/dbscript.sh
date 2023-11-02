#!/bin/bash

# Démarrer le service MariaDB
service mariadb start

while ! mysqladmin ping --silent; do
    sleep 1
done

# Connexion à MariaDB et création de la base de données et de l'utilisateur
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

sleep 1
echo "Start in safe mode"
exec mysqld_safe

# Afficher le statut
# echo "MariaDB database and user were created successfully!"
