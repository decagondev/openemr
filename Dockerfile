FROM openemr/openemr:latest

# Copy your custom code/changes
COPY . /var/www/localhost/htdocs/openemr/

# Fix permissions
RUN chown -R apache:apache /var/www/localhost/htdocs/openemr \
    && chmod 666 /var/www/localhost/htdocs/openemr/sites/default/sqlconf.php \
    && chmod -R 777 /var/www/localhost/htdocs/openemr/sites

WORKDIR /var/www/localhost/htdocs/openemr

# Use the official entrypoint script
CMD ["./openemr.sh"]

EXPOSE 80 443
