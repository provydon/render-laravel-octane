#!/bin/sh
set -e

echo "1"
ls -la

# Refresh env from .env.example using current environment values
while IFS= read -r line; do
  var=$(echo "$line" | cut -d= -f1)

  # Skip empty or commented lines
  [ -z "$var" ] && continue
  case "$var" in
    \#*|"RENDER_"*|"KUBERNETES_"*|"HOSTNAME"|"PATH") continue ;;
  esac

  # Get value from environment (POSIX-safe)
  val=$(eval "echo \${$var}")

  # Only write if value is non-empty
  if [ -n "$val" ]; then
    printf '%s=%s\n' "$var" "$val"
  fi
done < .env.example > .env

php artisan config:clear
php artisan config:cache
php artisan migrate --force
php artisan optimize

# Start app server
exec "$@"
