#!/usr/bin/env bash

# 构建脚本

# 设置变量
PROJECT_NAME="PageJoy"
BACKEND_DIR="backend"
FRONTEND_DIR="app"

# 构建后端
echo "Building backend..."
cd $BACKEND_DIR
# 这里可以添加后端构建命令，比如打包等
cd ..

# 构建前端 Web 版本
echo "Building frontend web..."
cd $FRONTEND_DIR
flutter build web
cd ..

echo "Build completed."