FROM php:8.1-apache

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    libssl-dev \
    unzip \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer require mongodb/mongodb

# Copier le fichier de configuration PHP
COPY ./docker-compose/php/conf.d/custom.ini /usr/local/etc/php/conf.d/custom.ini

# Activer les modules Apache nécessaires
RUN a2enmod rewrite
