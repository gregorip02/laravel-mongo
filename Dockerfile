FROM gregorip02/laravel-fpm:mongo
# Workdir app
ENV WORKDIR /var/www/app
WORKDIR $WORKDIR

# Install dependencies first
COPY composer.* $WORKDIR/
RUN composer install --no-interaction --no-scripts --no-autoloader

# Copy existing application directory contents
COPY --chown=www-data:www-data . $WORKDIR/
RUN composer dump-autoload

# Change file permissions
RUN find $WORKDIR/ -type d -exec chmod 755 "{}" \; && \
    find $WORKDIR/ -type f -exec chmod 644 "{}" \; && \
    chmod -R 777 $WORKDIR/storage $WORKDIR/bootstrap/cache

