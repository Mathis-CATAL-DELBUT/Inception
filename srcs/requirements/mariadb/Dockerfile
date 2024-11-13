FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y mariadb-server \
    && chmod +x ./tools/dbscript.sh

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/dbscript.sh ./

EXPOSE 3306

ENTRYPOINT ["bash", "./dbscript.sh"]
