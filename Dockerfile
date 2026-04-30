FROM openemr/openemr:latest

ARG CACHEBUST=20250430-3

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

RUN echo '\
<FilesMatch "\.(php|html|css|js)$">\
    Header set Cache-Control "no-cache, no-store, must-revalidate, max-age=0"\
    Header set Pragma "no-cache"\
    Header set Expires "Thu, 01 Jan 1970 00:00:00 GMT"\
</FilesMatch>' >> /etc/apache2/apache2.conf

WORKDIR /var/www/localhost/htdocs/openemr

# Official startup script
CMD ["./openemr.sh"]

EXPOSE 80
