#!/bin/bash

set -e;

if ["$LARAVEL_APP_KEY" == ""]
then
    php artisan key:generate
fi

nginx;
php-fpm;
