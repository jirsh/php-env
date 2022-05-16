FROM php:8-fpm-alpine

WORKDIR /var/www

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apk update && apk add --no-cache \
    build-base \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    gmp-dev

RUN docker-php-ext-configure gd \
    --with-jpeg

RUN docker-php-ext-install \
    mysqli \
    zip \
    gd \
    gmp

RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www

USER www

COPY --chown=www:www . /var/www

EXPOSE 9000
