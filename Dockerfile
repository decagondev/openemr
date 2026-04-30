FROM php:8.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    mariadb-client \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-install gd mysqli pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the entire OpenEMR code
COPY . /var/www/localhost/htdocs/openemr/

WORKDIR /var/www/localhost/htdocs/openemr

# Set proper permissions
RUN chown -R www-data:www-data /var/www/localhost/htdocs/openemr \
    && chmod -R 777 /var/www/localhost/htdocs/openemr/sites

# Enable Apache modules
RUN a2enmod rewrite

EXPOSE 80

CMD ["apache2-foreground"]
