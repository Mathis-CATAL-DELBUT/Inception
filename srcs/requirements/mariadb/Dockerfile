# Utilise l'image de base Debian Bullseye
FROM debian:bullseye

# Met à jour le système et effectue une mise à niveau des paquets
RUN apt update -y
RUN apt upgrade -y

# Installe le serveur MariaDB
RUN apt install mariadb-server -y

# Copie le fichier de configuration personnalisé dans le répertoire de configuration de MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copie un script "dbscript.sh" dans le répertoire de travail du conteneur
COPY tools/dbscript.sh ./

# Accorde l'exécution au script "dbscript.sh"
RUN chmod +x ./dbscript.sh

# Expose le port 3306, utilisé pour les connexions MariaDB
EXPOSE 3306

# Configure l'entrée principale (ENTRYPOINT) pour exécuter le script "dbscript.sh" avec le shell Bash
ENTRYPOINT ["bash", "./dbscript.sh"]
