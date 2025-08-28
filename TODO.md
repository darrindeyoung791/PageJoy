# PageJoy 项目 TODO List

## 架构设计概要

项目采用前后端分离架构，包含以下主要模块：

*   **`app/`**: Flutter 客户端应用，负责用户界面和交互。
*   **`backend/`**: Python 后端服务，提供 RESTful API，处理业务逻辑和数据库交互。
*   **`shared/`**: 存放前后端共享的资源，如 API 文档。
*   **`docs/`**: 项目文档。
*   **`scripts/`**: 自动化脚本。
*   **`.github/`**: GitHub Actions CI/CD 配置。

### 数据流

1.  `app/` 通过 HTTP 请求与 `backend/` 的 API 进行通信。
2.  `backend/` 接收请求，处理业务逻辑，与数据库交互。
3.  `backend/` 将处理结果（通常是 JSON 数据）返回给 `app/`。
4.  `app/` 接收数据并更新 UI。

## 任务细分

### 1. 项目初始化与环境搭建

*   [ ] 创建 `backend/` 目录。
*   [ ] 选择并初始化 Python 后端框架 (FastAPI 或 Django)。
*   [ ] 配置 Python 依赖管理 (`requirements.txt` 或 `pyproject.toml`)。
*   [ ] 配置代码质量工具 (black, isort, flake8/ruff)。
*   [ ] 配置测试框架 (pytest)。
*   [ ] 配置环境变量管理。
*   [ ] 初始化 Git 仓库 (如果尚未初始化)。
*   [ ] 更新 `.gitignore` 文件，排除虚拟环境、构建产物等。

### 2. 后端开发 (`backend/`)

#### 2.1 数据库设计与模型

*   [ ] 根据 `app/README.md` 中的数据库表结构，设计并实现 Python ORM 模型 (SQLAlchemy Models 或 Django Models)。
*   [ ] 配置数据库连接。
*   [ ] 设置数据库迁移工具 (Alembic 或 Django Migrations) 并创建初始迁移。

#### 2.2 API 设计与实现

*   [ ] 设计 RESTful API 端点 (可以先用 OpenAPI/Swagger YAML 在 `shared/` 中定义)。
*   [ ] 实现用户认证 API (注册、登录、获取用户信息)。
*   [ ] 实现文章相关 API (获取文章列表、获取文章详情、点赞)。
*   [ ] 实现创作者相关 API (获取创作者信息、关注/取消关注)。
*   [ ] 实现杂志相关 API (获取杂志列表、获取杂志详情)。
*   [ ] 实现会员订阅相关 API (获取订阅信息、处理支付Webhook - 模拟或集成)。
*   [ ] 实现收藏相关 API (获取收藏列表、添加/移除收藏)。
*   [ ] 添加 API 版本控制 (例如 `/api/v1/`)。
*   [ ] 集成身份验证和权限控制中间件。

#### 2.3 业务逻辑

*   [ ] 实现用户注册、登录逻辑。
*   [ ] 实现文章发布、编辑、状态管理逻辑 (如果需要后台管理)。
*   [ ] 实现文章浏览、点赞、分享逻辑。
*   [ ] 实现创作者关注逻辑。
*   [ ] 实现会员订阅、续费、过期逻辑。
*   [ ] 实现内容访问控制逻辑 (免费、会员、付费)。
*   [ ] 实现支付处理逻辑 (模拟或集成支付网关 SDK)。

#### 2.4 后端测试

*   [ ] 为 API 端点编写单元测试和集成测试。
*   [ ] 为业务逻辑编写单元测试。
*   [ ] 配置测试数据库。

#### 2.5 后端部署准备

*   [ ] 选择并配置 WSGI/ASGI 服务器 (Gunicorn/Uvicorn for FastAPI, Gunicorn for Django)。
*   [ ] 编写 Dockerfile 用于容器化后端应用。
*   [ ] 配置数据库连接池。
*   [ ] 配置日志记录。

### 3. 前端开发 (`app/`)

*   [ ] 配置 Flutter 项目，添加必要的依赖 (http client, state management, local db)。
*   [ ] 设计并实现 App 的整体 UI/UX (Material Design 3)。
*   [ ] 实现 Splash Screen (如果需要)。
*   [ ] 实现 Navigation Rail/Bar 切换逻辑。
*   [ ] 实现主页瀑布流布局。
*   [ ] 实现文章阅读页面。
*   [ ] 实现创作者页面。
*   [ ] 实现杂志页面。
*   [ ] 实现登录/注册页面。
*   [ ] 实现个人中心页面。
*   [ ] 实现收藏页面。
*   [ ] 实现会员订阅页面。
*   [ ] 实现底部 FAB 的显示/隐藏逻辑。
*   [ ] 实现内容渐变遮罩效果。
*   [ ] 集成 `http` 客户端，调用后端 API。
*   [ ] 实现本地数据存储 (SQLite) 用于缓存或离线数据。
*   [ ] 实现状态管理，管理用户信息、文章数据等。
*   [ ] 编写 Flutter 单元测试和 widget 测试。

### 4. 集成与测试

*   [ ] 联调前后端，确保 API 调用正确。
*   [ ] 进行端到端测试。
*   [ ] 修复集成过程中发现的问题。

### 5. 文档与部署

*   [ ] 编写 `docs/` 目录下的开发、部署文档。
*   [ ] (可选) 使用工具 (如 `openapi-generator`) 为 `app/` 生成 API 客户端代码。
*   [ ] 编写 `scripts/` 目录下的自动化构建和部署脚本。
*   [ ] 配置 `.github/workflows` 进行 CI/CD。
*   [ ] 选择云服务提供商 (如 AWS, GCP, Azure, Vercel, Heroku) 并部署应用。