FROM php:8.2-cli

WORKDIR /app

# system packages required for common PHP extensions and unzip
RUN apt-get update && \
    apt-get install -y --no-install-recommends git unzip zip libzip-dev && \
    docker-php-ext-install zip && \
    rm -rf /var/lib/apt/lists/*

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# copy app
COPY . /app

# install PHP dependencies (no-dev in build to keep image small)
RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader || true

# expose default Render port (Render provides $PORT at runtime)
EXPOSE 10000

# Start the PHP built-in server on the port Render provides via $PORT
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-10000} -t public"]
