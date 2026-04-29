# =============================================
# OpenEMR Dockerfile for Render / Production
# =============================================

FROM openemr/openemr:latest

# Copy your custom code from the repository (if you made any changes)
COPY . /var/www/localhost/htdocs/openemr/

# Fix file permissions (very important for Apache)
RUN chown -R apache:apache /var/www/localhost/htdocs/openemr \
    && chmod 666 /var/www/localhost/htdocs/openemr/sites/default/sqlconf.php \
    && chmod -R 777 /var/www/localhost/htdocs/openemr/sites

# Make sure the entrypoint script is executable
RUN chmod +x /var/www/localhost/htdocs/openemr/openemr.sh

WORKDIR /var/www/localhost/htdocs/openemr

# Use the official OpenEMR startup script
CMD ["./openemr.sh"]

EXPOSE 80 443
