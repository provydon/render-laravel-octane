#!/bin/sh
set -e

echo "1"
ls -la
#echo "2"
#cat .env

## Refresh env
while read line; do
  var=$(echo "$line" | cut -d= -f1)
  if [ -n "${!var}" ]; then
    echo "$var=${!var}"
  fi
done < .env.example > .env

php artisan config:clear
php artisan config:cache

# Run Laravel migrations
php artisan migrate --force

# Run Laravel optimize
php artisan optimize

# Start supervisord (or your app server)
exec "$@"
