# 🚀 Laravel Octane + FrankenPHP on Render

> **The solution to months of deployment struggles** - Get Laravel Octane working on Render in minutes, not months.

## 🚨 What This Fixes

| Issue | Error | Solution |
|-------|-------|----------|
| **FrankenPHP Permissions** | `Operation not permitted` | Non-root user + port 8000 |
| **Port Binding** | `Bind for 0.0.0.0:80 failed` | Use non-privileged port 8000 |
| **Cache Issues** | Service provider conflicts | Clear cache before app loads |

## 🔧 Quick Fixes

### 1. Dockerfile Changes
```dockerfile
# Create non-root user
ARG USER=appuser
RUN useradd ${USER}

# Remove capabilities & use port 8000
RUN setcap -r /usr/local/bin/frankenphp
ENV SERVER_NAME=:8000

# Switch user
USER ${USER}
```

### 2. Port Configuration
- **Container**: `8000` (non-privileged)
- **Local**: `3000` → `8000`
- **Render**: Auto-detects `8000`

## 🚀 Deploy in 3 Steps

### 1. **Test Locally**
```bash
docker-compose up --build
curl http://localhost:3000
```

### 2. **Push to Git**
```bash
git add .
git commit -m "Fix FrankenPHP deployment"
git push
```

### 3. **Connect to Render**
- Connect your repository
- Render auto-builds and deploys
- **Done!** 🎉

## ✅ Success Indicators

```
✅ Server running…. Local: http://0.0.0.0:8000
✅ Detected a new open port HTTP:8000  
✅ Your service is live 🎉
✅ No "Operation not permitted" errors
```

## 🔍 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| FrankenPHP won't start | Use port 8000, not 80 |
| Port conflicts | Change local port in docker-compose.yml |
| Cache issues | Clear bootstrap and storage cache |

## 📁 Key Files

```
docker/Dockerfile          # Container config
docker/supervisord.conf    # Process management  
docker-compose.yml         # Local setup
composer.json             # Dependencies
```

## 🎯 Why This Works

- **No privileged ports** (8000 vs 80)
- **Non-root user** (appuser vs root)  
- **No special capabilities** (setcap -r)
- **Clean dependencies** (no dev packages in prod)

---

**Deploy with confidence** - This setup has been tested and proven to work on Render! 🚀

---

## ☕ Support This Project

**Made with ❤️ by Providence Ifeosame**

If this project helped you finally get Laravel Octane working on Render after months of struggle, consider buying me a coffee!

[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/provydon)
