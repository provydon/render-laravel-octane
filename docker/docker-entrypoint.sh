#!/bin/sh
set -e

echo "1"
ls -la
#echo "2"
#cat .env

## Refresh env
php artisan config:clear
php artisan config:cache

# Run Laravel migrations
php artisan migrate --force

# Run Laravel optimize
php artisan optimize

# Start supervisord (or your app server)
exec "$@"
