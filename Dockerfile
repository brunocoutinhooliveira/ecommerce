FROM php:7.0-apache
# UPDATE APT-GET AND INSTALL LIBS
RUN apt-get update -y && apt-get install -y openssl zip vim unzip git libnss3 libpng-dev libjpeg-dev libfreetype6-dev libjpeg62-turbo-dev libgd-dev libwebp-dev

# INSTALL PHP EXTENSIONS
RUN docker-php-ext-install pdo pdo_mysql 

RUN docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \ 
    --with-jpeg=/usr/include/ \ 
    --with-webp=/usr/include/ \
    --with-xpm=/usr/include/

RUN docker-php-ext-install gd
# ENABLE APACHE MOD REWRITE
RUN a2enmod rewrite
# ENABLE APACHE MOD HEADER
RUN a2enmod headers
# INSTALL NODE
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs build-essential
# RUN ln -s Existing-file /usr/local/bin/node /usr/local/bin/nodejs
# INSTALL COMPOSER
RUN apt-get install -y openssl zip unzip git libnss3
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Copiar conteudo projeto
COPY ./ /var/www/html/ecommerce
# COPY config/php.ini $PHP_INI_DIR/php.ini
# Change www-data user to match the host system UID and GID and chown www directory
RUN usermod --non-unique --uid 1000 www-data \
    && groupmod --non-unique --gid 1000 www-data \
    && chown -R www-data:www-data /var/www
# Defines that the image will have port 80 to expose
EXPOSE 80
WORKDIR /var/www/html