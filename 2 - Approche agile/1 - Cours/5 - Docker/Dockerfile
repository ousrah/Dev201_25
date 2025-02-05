FROM php:8.2-fpm

ARG user
ARG uid

# Update package lists and install dependencies
RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Install the zip extension
RUN docker-php-ext-install zip


RUN apt update && apt install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
        libssl-dev \
        && rm -rf /var/lib/apt/lists/*




# Enable Apache modules
#RUN a2enmod rewrite
# Install MongoDB extension
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb


RUN docker-php-ext-install pdo_mysql xml mbstring exif pcntl bcmath gd 
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - 
RUN apt-get install -y nodejs

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

WORKDIR /var/www

USER $user