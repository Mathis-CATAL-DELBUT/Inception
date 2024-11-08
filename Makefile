all:
	mkdir -p /home/mcatal-d/data/mariadb
	mkdir -p /home/mcatal-d/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker container stop nginx mariadb wordpress
	docker network rm inception

fclean: clean
	@sudo rm -rf /home/mcatal-d/data/mariadb/*
	@sudo rm -rf /home/mcatal-d/data/wordpress/*
	@docker system prune -af

re: fclean all

.PHONY: all logs clean fclean
