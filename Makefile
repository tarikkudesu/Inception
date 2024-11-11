INCEPTION_LOGIN	=	tamehri
WP_DIR			=	/home/$(INCEPTION_LOGIN)/data/wordpress
DB_DIR			=	/home/$(INCEPTION_LOGIN)/data/database
BU_DIR			=	/home/$(INCEPTION_LOGIN)/data/backup
IMAGES			=	$$(docker image ls -aq | grep -v 1ddedd6ca43f)
NETWORKS		=	$$(docker network ls -q --filter "type=custom")
VOLUMES			=	$$(docker volume ls -q)
CONTAINERS		=	$$(docker ps -aq)
COMPOSEFILE		=	srcs/docker-compose.yml
GREEN			=	\033[0;32m
RESET			=	\033[0m

all: up

up:
	@sudo mkdir -p $(WP_DIR) $(DB_DIR) $(BU_DIR)
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) up -d

down:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) down

build:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) build

ps:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) ps

top:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) top

stop:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) stop

restart:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) restart

ls:
	@echo "______________________________________________________________________"
	@docker images
	@echo "______________________________________________________________________"
	@docker ps --all
	@echo "______________________________________________________________________"
	@docker volume ls
	@echo "______________________________________________________________________"
	@docker network ls --filter "type=custom"

cleancontainers:
	@echo -n " ✔ cleaning containers ..."
	@docker stop $(CONTAINERS) > /dev/null 2>&1 || true
	@docker rm -f $(CONTAINERS) > /dev/null 2>&1 || true
	@echo "$(GREEN)\tDone$(RESET)"

cleanimages:
	@echo -n " ✔ cleaning images ..."
	@docker image rm -f $(IMAGES) > /dev/null 2>&1 || true
	@echo "$(GREEN)\t\tDone$(RESET)"

cleannetworks:
	@echo -n " ✔ cleaning networks ..."
	@docker network rm -f $(NETWORKS) > /dev/null 2>&1 || true
	@echo "$(GREEN)\tDone$(RESET)"

cleanvolumes:
	@echo -n " ✔ cleaning volumes ..."
	@docker volume rm -f $(VOLUMES) > /dev/null 2>&1 || true
	@echo "$(GREEN)\t\tDone$(RESET)"

clean: cleancontainers cleanimages cleannetworks

fclean: clean cleanvolumes
	@docker system prune --all --force > /dev/null 2>&1 || true
	@sudo rm -rf $(WP_DIR) $(DB_DIR) $(BU_DIR)

prune:
	@docker system prune --all --force > /dev/null 2>&1 || true
	@sudo rm -rf $(WP_DIR) $(DB_DIR) $(BU_DIR)

re: fclean up

.PHONY: down build ps top stop restart ls cleancontainers cleanimages cleannetworks cleanvolumes clean fclean prune re
