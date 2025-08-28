#!/usr/bin/env bash

# 部署脚本

# 设置变量
PROJECT_NAME="PageJoy"
BACKEND_DIR="backend"
FRONTEND_DIR="app"
DEPLOY_DIR="/var/www/pagejoy"

# 部署后端
echo "Deploying backend..."
# 这里添加后端部署命令，比如复制文件到部署目录，重启服务等

# 部署前端 Web 版本
echo "Deploying frontend web..."
cd $FRONTEND_DIR
flutter build web
# 这里添加前端部署命令，比如复制 build/web 目录到Web服务器目录

echo "Deployment completed."