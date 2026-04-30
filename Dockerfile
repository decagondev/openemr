FROM openemr/openemr:latest

# Copy your fork's custom files (if any)
COPY . /var/www/localhost/htdocs/openemr/

# Ensure proper permissions
RUN chown -R apache:apache /var/www/localhost/htdocs/openemr \
    && chmod -R 777 /var/www/localhost/htdocs/openemr/sites \
    && chmod 666 /var/www/localhost/htdocs/openemr/sites/default/sqlconf.php 2>/dev/null || true

WORKDIR /var/www/localhost/htdocs/openemr

CMD ["./openemr.sh"]

EXPOSE 80 443
