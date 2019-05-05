.PHONY: install up down install-magento2 console logs-server

install:
	docker build -t 00f100/php-fpm-zts:7.0.33 ./infra/php-fpm-zts/7.0.33; \
	docker build --build-arg UID=www-data --build-arg GID=www-data -t 00f100/php-composer:7.0.33 ./infra/php-composer/7.0.33; \
	mkdir magento2; \
	sudo chown -R :www-data magento2; \
	chmod 2775 magento2;
	docker-compose up -d;

up:
	docker-compose up -d;

down:
	docker-compose stop;

console:
	docker exec -it --user www-data:www-data $(shell docker ps -aqf "name=php-7-0-33-daemon") /bin/bash

install-magento2: 
	mkdir -p magento2/magento2.3; \
	docker run -it --rm --user www-data:www-data -v "$(shell pwd)/magento2:/var/www/html" 00f100/php-composer:7.0.33 create-project --repository=https://repo.magento.com/ magento/project-community-edition=2.1.7

logs-server:
	docker exec -it $(shell docker ps -aqf "name=nginx") /bin/bash -c "tail -f /var/log/nginx/*.log"