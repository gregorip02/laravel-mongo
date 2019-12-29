FROM gregorip02/laravel-fpm:mongo
# Workdir app
ENV WORKDIR /opt/app
WORKDIR $WORKDIR

# Install dependencies first
COPY composer.* $WORKDIR/
RUN composer install --no-interaction --no-scripts --no-autoloader --no-cache

# Add source code and autoload then
COPY . $WORKDIR/
RUN composer dump-autoload

# Expose the fpm port
EXPOSE 9000
