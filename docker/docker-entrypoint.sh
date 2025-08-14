#!/bin/sh
set -e

echo "1"
ls -la

# Refresh env from .env.example using current environment values
#!/bin/sh
set -e
while IFS= read -r line; do
  var=$(echo "$line" | cut -d= -f1)
  [ -z "$var" ] && continue
  case "$var" in
    \#*|"RENDER_"*|"KUBERNETES_"*|"HOSTNAME"|"PATH") continue ;;
  esac

  current_val=$(eval "echo \${$var}")

  if [ -n "$current_val" ]; then
    printf '%s=%s\n' "$var" "$current_val"
  else
    default_val=$(echo "$line" | cut -d= -f2-)
    case "$default_val" in
      *'$('*')'*) # if default contains a command
        eval "default_val=$default_val"
        ;;
    esac
    printf '%s=%s\n' "$var" "$default_val"
  fi
done < .env.example > .env

php artisan config:clear
php artisan config:cache
php artisan migrate --force
php artisan optimize

# Start app server
exec "$@"
