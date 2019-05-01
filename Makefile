.PHONY: install-magento2

install-magento2: 
	mkdir magento2/magento2.3; \
	sudo docker run -it --rm --user 33:33 -v magento2=/var/www/html 00f100/php-composer:7.0.33 create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2.3