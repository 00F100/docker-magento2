.PHONY: install up down install-magento2 logs-server

install:
	sudo docker build -t 00f100/php-fpm-zts:7.0.33 ./infra/php-fpm-zts/7.0.33; \
	sudo docker build -t 00f100/php-composer:7.0.33 ./infra/php-composer/7.0.33; \
	mkdir magento2; \
	sudo docker-compose up -d;

up:
	sudo docker-compose up -d;

down:
	sudo docker-compose stop;

install-magento2: 
	mkdir -p magento2/magento2.3; \
	sudo docker run -it --rm --user 33:33 -v magento2=/var/www/html 00f100/php-composer:7.0.33 create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2.3

logs-server:
	sudo docker exec -it $(shell sudo docker ps -aqf "name=nginx") bash -c "tail -f /var/log/nginx/*.log"