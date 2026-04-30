FROM php:8.4-apache

# Install required PHP extensions + tools
RUN apt-get update && apt-get install -y \
    mariadb-client \
    libpng-dev libjpeg-dev libxml2-dev libzip-dev \
    unzip curl git \
    && docker-php-ext-install gd mysqli pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy OpenEMR code
COPY . /var/www/localhost/htdocs/openemr/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/localhost/htdocs/openemr \
    && chmod -R 755 /var/www/localhost/htdocs/openemr \
    && chmod -R 777 /var/www/localhost/htdocs/openemr/sites

# Configure Apache to serve OpenEMR correctly
COPY <<EOF /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/localhost/htdocs/openemr

    <Directory /var/www/localhost/htdocs/openemr>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /var/www/localhost/htdocs/openemr/sites>
        AllowOverride None
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable required modules
RUN a2enmod rewrite

WORKDIR /var/www/localhost/htdocs/openemr

EXPOSE 80

CMD ["apache2-foreground"]
