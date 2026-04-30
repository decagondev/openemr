FROM openemr/openemr:latest

# Copy your fork's files
COPY . /var/www/localhost/htdocs/openemr/

# Fix permissions and ensure required folders exist
RUN chown -R apache:apache /var/www/localhost/htdocs/openemr \
    && chmod -R 777 /var/www/localhost/htdocs/openemr/sites \
    && mkdir -p /var/www/localhost/htdocs/openemr/sites/default/documents \
    && mkdir -p /var/www/localhost/htdocs/openemr/sites/default/edi \
    && mkdir -p /var/www/localhost/htdocs/openemr/sites/default/era

# Make sure Apache listens on port 80 (important for Render)
RUN echo "Listen 80" >> /etc/apache2/ports.conf

WORKDIR /var/www/localhost/htdocs/openemr

# Official startup script
CMD ["./openemr.sh"]

EXPOSE 80
