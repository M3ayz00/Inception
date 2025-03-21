HOME=$(shell echo ~)
DOCKER_COMPOSE=${HOME}/Desktop/Inception/srcs/docker-compose.yml

up:
	mkdir -p ${HOME}/data/wordpress ${HOME}/data/mariadb ${HOME}/data/adminer
	@docker compose -f $(DOCKER_COMPOSE) up -d

down:
	@docker compose -f $(DOCKER_COMPOSE) down  -v 

status:
	@docker compose -f $(DOCKER_COMPOSE) ps

#for testing
logs:
	@docker compose -f $(DOCKER_COMPOSE) logs -f

buildup:	
	mkdir -p ${HOME}/data/wordpress ${HOME}/data/mariadb ${HOME}/data/adminer
	@docker compose -f $(DOCKER_COMPOSE) up -d --build

re: down buildup

fclean:
	@docker system prune -af --volumes

hre: down fclean buildup
