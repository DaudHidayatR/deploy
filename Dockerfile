FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
        nginx \
        wget \
        icu-dev \
        libzip-dev \
    && docker-php-ext-install \
        intl \
        zip

RUN mkdir -p /run/nginx

COPY docker/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /app
COPY . /app
COPY ./src /app

RUN sh -c "wget http://getcomposer.org/composer.phar && chmod a+x composer.phar && mv composer.phar /usr/local/bin/composer"
RUN cd /app && \
    composer update --no-dev

RUN chown -R www-data: /app

CMD ["sh", "/app/docker/startup.sh"]
