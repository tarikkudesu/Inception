INCEPTION_LOGIN	=	tamehri
WP_DIR			=	/home/$(INCEPTION_LOGIN)/data/wordpress
DB_DIR			=	/home/$(INCEPTION_LOGIN)/data/database
BU_DIR			=	/home/$(INCEPTION_LOGIN)/data/backup
NETWORKS		=	$$(docker network ls -q --filter "type=custom")
IMAGES			=	$$(docker image ls -aq)
VOLUMES			=	$$(docker volume ls -q)
CONTAINERS		=	$$(docker ps -aq)
COMPOSEFILE		=	srcs/docker-compose.yml
GREEN			=	\033[0;32m
RESET			=	\033[0m
cols			=	$$(tput cols)
SE				=	$$(printf "%-$(cols)s" "_" | tr ' ' '_')

all: up

up: mkdir
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@ --build -d
down:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@
build:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@
ps:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@ --all
top:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@
stop:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@
restart:
	@INCEPTION_LOGIN=$(INCEPTION_LOGIN) docker compose -f $(COMPOSEFILE) $@

mkdir:
	@echo -n " ✔ creating volume folders ..."
	@sudo mkdir -p $(WP_DIR) $(DB_DIR) $(BU_DIR)
	@echo "$(GREEN)\tDone$(RESET)"
rmdir:
	@echo -n " ✔ cleaning volume folders ..."
	@sudo rm -rf $(WP_DIR) $(DB_DIR) $(BU_DIR)
	@echo "$(GREEN)\tDone$(RESET)"

ls:
	@echo $(SE) && docker images && echo $(SE) && docker ps --all
	@echo $(SE) && docker volume ls && echo $(SE) && docker network ls --filter "type=custom"

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

fclean: clean cleanvolumes rmdir

prune: fclean
	@echo -n " ✔ system prune ..."
	@docker system prune --all --force > /dev/null 2>&1 || true
	@echo "$(GREEN)\t\tDone$(RESET)"

re: fclean up

.PHONY: up down build ps top stop restart mkdir rmdir ls cleancontainers cleanimages cleannetworks cleanvolumes clean fclean prune re
