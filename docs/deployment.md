# PageJoy 项目部署文档

## 部署环境要求

### 后端
- Python 3.8+
- 数据库 (SQLite/PostgreSQL/MySQL)
- Web 服务器 (Nginx/Apache)
- WSGI/ASGI 服务器 (Gunicorn/Uvicorn)

### 前端
- Flutter SDK
- Android Studio/Xcode (用于构建移动端)
- Web浏览器 (用于Web端)

## 部署步骤

### 后端部署

1. 克隆代码库到服务器
2. 创建并激活虚拟环境
3. 安装依赖: `pip install -r requirements.txt`
4. 配置环境变量
5. 运行数据库迁移 (如果使用)
6. 配置 Web 服务器反向代理到 ASGI 服务器
7. 启动 ASGI 服务器 (如 Uvicorn)

### 前端部署

#### Web端
1. 进入 `app/` 目录
2. 构建 Web 版本: `flutter build web`
3. 将 `build/web` 目录部署到 Web 服务器

#### 移动端
1. 进入 `app/` 目录
2. 构建 APK: `flutter build apk` (Android)
3. 构建 IPA: `flutter build ios` (iOS, 需要在 macOS 上进行)

## CI/CD

使用 GitHub Actions 进行持续集成和部署。

## 监控和日志

(待完善)