# PageJoy 项目开发文档

## 目录结构

- `app/`: Flutter 客户端应用
- `backend/`: Python 后端服务
- `shared/`: 前后端共享资源
- `docs/`: 项目文档
- `scripts/`: 自动化脚本
- `.github/`: GitHub Actions CI/CD 配置

## 开发环境搭建

### 后端 (Python)

1. 进入 `backend/` 目录
2. 创建虚拟环境: `python -m venv venv`
3. 激活虚拟环境:
   - Windows: `venv\Scripts\activate`
   - macOS/Linux: `source venv/bin/activate`
4. 安装依赖: `pip install -r requirements.txt`
5. 运行开发服务器: `uvicorn main:app --reload`

### 前端 (Flutter)

1. 确保已安装 Flutter SDK
2. 进入 `app/` 目录
3. 获取依赖: `flutter pub get`
4. 运行应用: `flutter run`

## 数据库设计

参考 `app/README.md` 中的数据库表结构和ER图。

## API 设计

API 文档位于 `shared/api.yaml` (待创建)。

## 部署

(待完善)