DOCKER_COMPOSE=$(shell echo ~)/Desktop/Inception/srcs/docker-compose.yml

up:
	@docker compose -f $(DOCKER_COMPOSE) up -d

down:
	@docker compose -f $(DOCKER_COMPOSE) down  -v 


#for testing
logs:
	@docker compose -f $(DOCKER_COMPOSE) logs -f

buildup:	
	@docker compose -f $(DOCKER_COMPOSE) up -d --build

re: down buildup

fclean:
	@docker system prune -af --volumes

hre: down fclean buildup
