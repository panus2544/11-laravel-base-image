FROM php:7.2-fpm-alpine AS PHPBuilder

RUN apk add --update zip unzip nginx bash
RUN mkdir -p /run/nginx

RUN docker-php-ext-install pdo pdo_mysql mbstring exif
RUN docker-php-ext-enable pdo pdo_mysql mbstring exif

RUN php -r "copy('https://getcomposer.org/installer', '/root/composer-setup.php');"
RUN php /root/composer-setup.php --install-dir=/bin --filename=composer

COPY ./entrypoint.sh .
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./php-fpm.conf /usr/local/etc/php-fpm.d/zzz-php-fpm.conf
COPY ./start.sh ./start.sh

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "./start.sh" ]
