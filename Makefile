all: hosts
	@sudo mkdir -p ~/jgomes-c/data/wordpress && sudo mkdir -p ~/jgomes-c/data/mariadb
	@docker-compose -f srcs/docker-compose.yml up -d --build

hosts:
	@if [ "$(DOMAIN)" != "jgomes-c.42.fr" ]; then \
		sudo touch /etc/hosts; \
		sudo cp /etc/hosts ./host_backup; \
		sudo touch /etc/hosts; \
		sudo rm /etc/hosts; \
		sudo cp ./srcs/requirements/tools/hosts /etc/; \
	fi

down:
	@docker-compose -f srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa);\
		docker rm $$(docker ps -qa);\
		docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker network rm $$(docker network ls -q);\
		sudo rm -rf /etc/hosts
		sudo mv ./host_backup /etc/hosts
		sudo rm -rf ~/jgomes-c/data/mariadb 
		sudo rm -rf ~/jgomes-c/data/wordpress

.PHONY: all re down clean
