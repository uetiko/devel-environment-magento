D_COMPOSE=docker compose
D_EXEC=docker exec -it
D_SERVICE_FPM=magento-php

build:
	$(D_COMPOSE) build
	docker build -f dockerfiles/php/8.2/Dockerfile --tag=devel ./etc/infrastructure/php/8.2/

up:
	$(D_COMPOSE) up -d
down:
	$(D_COMPOSE) down
upgrade:
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento setup:upgrade
compile:
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento setup:di:compile
deploy-admin:
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento setup:static-content:deploy -j 4 --area adminhtml en_US
deploy:
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento setup:static-content:deploy es_MX -j 15 -f
cache:
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento cache:flush
compose-install:
	$(D_EXEC) $(D_SERVICE_FPM) composer install --optimize-autoloader
compose-update:
	$(D_EXEC) $(D_SERVICE_FPM) composer update --optimize-autoloader
reindex:
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento indexer:reset
	$(D_EXEC) $(D_SERVICE_FPM) bin/magento indexer:reindex
create-project:
	$(D_EXEC) $(D_SERVICE_FPM) composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.6 .

chown-project:
	sudo chown -R 1000:1000 ~/work/personal/proyectos/magento/source