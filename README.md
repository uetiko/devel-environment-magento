# Instalación de Magento 2.4.6 con Docker

Este documento describe cómo instalar Magento 2.4.6 utilizando Docker.

## 1. Iniciar los contenedores de Docker

Primero, necesitas iniciar los contenedores de Docker. Puedes hacerlo con el siguiente comando:

```bash
docker-compose up -d
```
## 2 Descargar Magento 2.4.6
A continuación, debes descargar Magento. Puedes hacerlo con Composer. Primero, debes entrar en el contenedor de PHP:

```bash
docker exec -it magento-php fish
```

Luego, puedes usar Composer para crear un nuevo proyecto de Magento:

```bash
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.6 .
```
Este paso te pedirá tus credenciales de Magento Marketplace. Si no tienes una cuenta, puedes crear una en [https://commercemarketplace.adobe.com/](https://commercemarketplace.adobe.com/). 
Una vez que accedas, podrás ver tus credenciales de acceso en la sección de tu perfil > select Access Keys o creart nuevas credenciales. 

Esto descargará Magento en la carpeta actual (/var/www/html).

## 3. Instalar Magento 2.4.6

Una vez que hayas descargado Magento, puedes instalarlo con el comando de instalación de Magento. Aquí tienes un ejemplo de cómo podría ser este comando:

```bash
bin/magento setup:install \
    --base-url=http://localhost \
    --db-host=db \
    --db-name=magento \
    --db-user=magento \
    --db-password=magento \
    --admin-firstname=admin \
    --admin-lastname=admin \
    --admin-email=admin@example.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=en_US \
    --currency=USD \
    --timezone=America/New_York \
    --use-rewrites=1 \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-port=9200
```
Este comando instala Magento con una serie de opciones, como la URL base, las credenciales de la base de datos, la información del administrador, la configuración regional y la configuración de Elasticsearch. Debes ajustar estas opciones según tus necesidades.

## 4. Configurar los permisos de los archivos

Después de instalar Magento, debes asegurarte de que los permisos de los archivos sean correctos. Magento recomienda los siguientes permisos:

```bash
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R :www-data .
chmod u+x bin/magento
```

## 5. Limpiar la caché

Por último, debes limpiar la caché de Magento para asegurarte de que todos los cambios se apliquen correctamente:
```bash
bin/magento cache:clean
```

Recuerda editar tu archivo `/etc/hosts` para que `localhost` apunte a `magento.dev`.

```
127.0.0.1 magento.dev
```

¡Y eso es todo! Ahora deberías tener una instalación de Magento 2.4.6 funcionando en tus contenedores de Docker. Recuerda que estos son solo los pasos básicos y es posible que necesites realizar más configuraciones según tus necesidades específicas.