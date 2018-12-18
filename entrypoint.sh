#!/bin/bash
set -e

rm -f .env
touch .env

for env in "${!LARAVEL_@}"

do
  echo ${env#"LARAVEL_"}=${!env} >> .env;
done

exec "$@"
