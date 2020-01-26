FROM gregorip02/laravel-fpm:mongo
# Workdir app
ENV WORKDIR /opt/app
WORKDIR $WORKDIR

# Install dependencies first
COPY composer.* $WORKDIR/
RUN composer install --no-interaction --no-scripts --no-autoloader --no-cache

# Add user for laravel application
RUN addgroup -g 1000 -S www-data && \
    adduser -S www-data -G www-data -u 1000 -s /bin/sh

# Copy existing application directory contents
COPY . $WORKDIR/
RUN composer dump-autoload

# Copy existing application directory permissions
COPY --chown=www-data:www-data . $WORKDIR/

# Change file permissions
RUN find $WORKDIR/ -type d -exec chmod 755 "{}" \;
RUN find $WORKDIR/ -type f -exec chmod 644 "{}" \;
RUN chmod -R 777 $WORKDIR/storage $WORKDIR/bootstrap/cache

# Change current user to www-data
USER www-data
