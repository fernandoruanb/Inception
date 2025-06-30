#Target

TARGET="./srcs/docker-compose.yml"

# up the services

up:
	@docker compose -f $(TARGET) up -d --build

# stop the services

down:
	@docker compose -f $(TARGET) down

# build the images

build:
	@docker compose -f $(TARGET)

#clean

clean: down
	@docker container prune -f
	@docker image prune -af
	@docker network prune -f

#fclean

fclean: down
	@echo "Cleaning everything..."
	@docker system prune -a --volumes -f || true
	@bash -c 'docker volume rm -f $$(docker volume ls -q)' || true

# restart

re: clean up

.PHONY: up down build clean fclean re
