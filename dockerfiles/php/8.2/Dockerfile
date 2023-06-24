FROM php:8.2-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    libfreetype6-dev \
            libjpeg62-turbo-dev \
            libpng-dev \
            libzip-dev \
            libbz2-dev \
            libxml2-dev \
            libxslt1-dev \
            libicu-dev \
            libonig-dev \
            libssl-dev \
            libcurl4-openssl-dev \
            libgmp-dev \
            libreadline-dev \
            libxslt-dev \
            unzip \
            curl \
            git \
            vim \
            nano \
            redis-tools \
            net-tools \
            iputils-ping \
            zsh \
            fish
RUN docker-php-ext-install -j$(nproc) \
    bcmath ctype
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) \
    dom fileinfo filter
RUN docker-php-ext-install -j$(nproc) \
    iconv
RUN docker-php-ext-install -j$(nproc) \
    intl
RUN docker-php-ext-install -j$(nproc) \
    pdo_mysql
RUN docker-php-ext-install -j$(nproc) \
    simplexml soap sockets
RUN docker-php-ext-install -j$(nproc) \
    xmlwriter
RUN docker-php-ext-install -j$(nproc) \
    xsl
RUN docker-php-ext-install -j$(nproc) \
    zip

RUN pecl install -o -f \
    apcu \
    xdebug \
    redis
RUN docker-php-ext-enable \
    apcu \
    xdebug \
    opcache \
    redis

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data
RUN chsh -s /usr/bin/fish www-data
RUN chown -R www-data:www-data /var/www

USER www-data

VOLUME /var/www
WORKDIR /var/www/html

EXPOSE 9000
EXPOSE 9001
EXPOSE 9003
ENV XDEBUG_PORT 9003