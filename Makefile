WP_DIR		=	/home/tamehri/data/wordpress
DB_DIR		=	/home/tamehri/data/database
CONTAINERS	=	$$(docker ps -aq)
IMAGES		=	$$(docker image ls -aq | grep -v fd320476a1f2 | grep -v c7f9867d6721)
VOLUMES		=	$$(docker volume ls -q)
NETWORKS	=	$$(docker network ls -q --filter "type=custom")
COMPOSEFILE	=	srcs/docker-compose.yml

all: up

up:
	@sudo mkdir -p $(WP_DIR)
	@sudo mkdir -p $(DB_DIR)
	@docker-compose -f $(COMPOSEFILE) up -d

down:
	@docker-compose -f $(COMPOSEFILE) down
	@sudo rm -rf $(WP_DIR)
	@sudo rm -rf $(DB_DIR)

build:
	@docker-compose -f $(COMPOSEFILE) build

ps:
	@docker-compose -f $(COMPOSEFILE) ps

top:
	@docker-compose -f $(COMPOSEFILE) top

stop:
	@docker-compose -f $(COMPOSEFILE) stop

restart:
	@docker-compose -f $(COMPOSEFILE) restart

clearv:
	@sudo rm -rf /home/ubuntu/Desktop/Inception/wpdb/*
	@sudo rm -rf /home/ubuntu/Desktop/Inception/wordpress/*

ls:
	@echo "______________________________________________________________________"
	@docker images
	@echo "______________________________________________________________________"
	@docker ps -a
	@echo "______________________________________________________________________"
	@docker volume ls
	@echo "______________________________________________________________________"
	@docker network ls --filter "type=custom"

cleancontainers:
	@echo "cleaning containers ..."
	@if [ -z "$(CONTAINERS)" ]; then \
		echo "No containers"; \
	else \
		docker stop $(CONTAINERS) && docker rm -f $(CONTAINERS) || true; \
	fi

cleanimages:
	@echo "cleaning images ..."
	@if [ -z "$(IMAGES)" ]; then \
		echo "No images"; \
	else \
		docker image rm -f $(IMAGES) || true; \
	fi

cleanvolumes:
	@echo "cleaning volumes ..."
	@if [ -z "$(VOLUMES)" ]; then \
		echo "No volumes"; \
	else \
		docker volume rm -f $(VOLUMES) || true; \
	fi

cleannetworks:
	@echo "cleaning networks ..."
	@if [ -z "$(NETWORKS)" ]; then \
		echo "No networks"; \
	else \
		docker network rm -f $(NETWORKS) || true; \
	fi

clean: cleancontainers cleanimages cleanvolumes cleannetworks
	@sudo rm -rf $(WP_DIR)
	@sudo rm -rf $(DB_DIR)

re: down up
