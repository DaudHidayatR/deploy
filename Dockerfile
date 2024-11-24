FROM php:8.2-fpm-alpine

# Install necessary packages and PHP extensions
RUN apk add --no-cache \
        nginx \
        wget \
        icu-dev \
        libzip-dev \
    && docker-php-ext-install \
        intl \
        zip

# Create necessary directories
RUN mkdir -p /run/nginx /app

# Copy only composer.json and composer.lock
COPY src/composer.json src/composer.lock /app/

# Copy Nginx configuration
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Set the working directory to /app
WORKDIR /app

# Install Composer
RUN wget -q -O /usr/local/bin/composer https://getcomposer.org/composer.phar \
    && chmod +x /usr/local/bin/composer

# Install PHP dependencies
RUN composer install --no-dev

# Copy the rest of the application files after dependencies are installed
COPY src/ /app/

# Set ownership of application files
RUN chown -R www-data:www-data /app

# Use JSON array syntax for CMD to prevent issues with signal handling
CMD ["sh", "/app/docker/startup.sh"]
