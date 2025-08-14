# Docker Configuration

Files:
- `Dockerfile`: Main Docker image configuration
- `supervisord.conf`: Process management configuration
- `php.ini`: PHP configuration

## Usage

```bash
# From project root
docker build -t render-laravel-frankenphp -f docker/Dockerfile .
docker run -p 8000:8000 render-laravel-frankenphp
``` 