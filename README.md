# PageJoy 悦阅：沉浸式电子杂志

- 极简界面布局，助用户全身心专注于文字阅览本身
- 多端支持，为各种尺寸的桌面端和移动端适配界面
- [Planned] AI 常伴左右，提供资讯文章总结、个性化推荐等功能


## 页面与功能列表

- 使用 Flutter 创建符合 Material Design 3 的美观单页应用。中文字体使用 Noto Sans SC，英文使用 Lato

- [Planned] Splash screen
- 主页
    - 推送瀑布流页面，类似小红书的布局
    - 收藏页面，存放用户点过红心的文章和关注的创作者
    - 个人页面，展示用户信息，会员订阅状态，历史记录和[Panned]设置
    - 上述三个单独页面可以通过 Material Design 中的 navigation rail（桌面横屏端）/navigation bar（移动竖屏端）切换
- 登录/注册页面
    - 不登录也能看文章，但是点赞、关注创作者和订阅会员需要登录
    - 注册界面需要用户设置密码时重复一次

- 文章阅读页面
    - 内容从上到下分别是：标题，信息，AI 摘要，正文
    - 标题下的信息包括：日期、创作者。未关注创作者时有加关注按钮
    - AI 摘要部分可以折叠或没有
    - 底部有红心和分享按钮，页面内容下滑隐藏，上划浮现。类似一个底部居中 FAB，或者 Gemini 在安卓手机上语音对话的界面控件
    - 顶部底部附近的文字、图片等内容与屏幕/控件边界处有不透明度渐变遮罩模糊效果
    - 需会员订阅才能阅读的文章，不显示摘要，仅预览前2%的内容并使用不透明度渐变遮罩模糊效果处理末尾。并放置跳转到订阅会员的链接
- 创作者页面
    - 内容从上到下分别是：背景图，头像名称，信息，创作的文章
    - 参考普通 UGC 平台的设计
- 杂志页面
    - 视作特殊的创作者
- 会员订阅界面
    - 展示个人用户的订阅信息
    - [Planned]购买套餐和历史订单


## 开发环境设置

### 后端 (Python/FastAPI)

1. 进入 `backend` 目录:
   ```bash
   cd backend
   ```

2. 创建虚拟环境:
   ```bash
   python -m venv venv
   ```

3. 激活虚拟环境:
   - Windows: `venv\Scripts\activate`
   - macOS/Linux: `source venv/bin/activate`

4. 安装依赖:
   ```bash
   pip install -r requirements.txt
   ```

5. 运行开发服务器:
   ```bash
   uvicorn main:app --reload
   ```

### 前端 (Flutter)

1. 进入 `app` 目录:
   ```bash
   cd app
   ```

2. 获取依赖:
   ```bash
   flutter pub get
   ```

3. 运行应用:
   ```bash
   flutter run
   ```

### 启动整个开发环境

在项目根目录运行:
```bash
start_dev.bat
```

这将同时启动后端和前端开发服务器。


## 数据库表结构汇总

- 使用 sqlite 存放数据

### 1. 用户表 (user)

| 字段名        | 类型         | 允许空 | 默认值                      | 说明     |
| ------------- | ------------ | ------ | --------------------------- | -------- |
| id            | INT          | NO     | AUTO_INCREMENT              | 主键     |
| username      | VARCHAR(50)  | NO     |                             | 用户名   |
| password_hash | VARCHAR(255) | NO     |                             | 密码哈希 |
| email         | VARCHAR(100) | YES    | NULL                        | 邮箱     |
| phone         | VARCHAR(20)  | YES    | NULL                        | 电话     |
| wechat_id     | VARCHAR(50)  | YES    | NULL                        | 微信ID   |
| created_at    | DATETIME     | NO     | CURRENT_TIMESTAMP           | 创建时间 |
| updated_at    | DATETIME     | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间 |

### 2. 角色表 (role)

| 字段名 | 类型        | 允许空 | 默认值         | 说明     |
| ------ | ----------- | ------ | -------------- | -------- |
| id     | INT         | NO     | AUTO_INCREMENT | 主键     |
| name   | VARCHAR(20) | NO     |                | 角色名称 |

### 3. 用户角色关联表 (user_role)

| 字段名  | 类型 | 允许空 | 默认值 | 说明   |
| ------- | ---- | ------ | ------ | ------ |
| user_id | INT  | NO     |        | 用户ID |
| role_id | INT  | NO     |        | 角色ID |

### 4. 文章表 (article)

| 字段名     | 类型                                 | 允许空 | 默认值                      | 说明     |
| ---------- | ------------------------------------ | ------ | --------------------------- | -------- |
| id         | INT                                  | NO     | AUTO_INCREMENT              | 主键     |
| title      | VARCHAR(255)                         | NO     |                             | 标题     |
| content    | TEXT                                 | NO     |                             | 内容     |
| status     | ENUM('draft','published','archived') | NO     | 'draft'                     | 状态     |
| is_premium | BOOLEAN                              | NO     | FALSE                       | 是否付费 |
| price      | DECIMAL(10,2)                        | YES    | NULL                        | 价格     |
| created_at | DATETIME                             | NO     | CURRENT_TIMESTAMP           | 创建时间 |
| updated_at | DATETIME                             | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间 |
| view_count | INT                                  | NO     | 0                           | 浏览次数 |

### 5. 杂志表 (magazine)

| 字段名               | 类型         | 允许空 | 默认值                      | 说明       |
| -------------------- | ------------ | ------ | --------------------------- | ---------- |
| id                   | INT          | NO     | AUTO_INCREMENT              | 主键       |
| name                 | VARCHAR(100) | NO     |                             | 名称       |
| description          | TEXT         | YES    | NULL                        | 描述       |
| cover_image          | VARCHAR(255) | YES    | NULL                        | 封面图     |
| is_premium           | BOOLEAN      | NO     | FALSE                       | 是否付费   |
| subscription_plan_id | INT          | YES    | NULL                        | 订阅计划ID |
| created_at           | DATETIME     | NO     | CURRENT_TIMESTAMP           | 创建时间   |
| updated_at           | DATETIME     | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间   |

### 6. 文章作者关联表 (article_writer)

| 字段名     | 类型    | 允许空 | 默认值 | 说明         |
| ---------- | ------- | ------ | ------ | ------------ |
| article_id | INT     | NO     |        | 文章ID       |
| user_id    | INT     | NO     |        | 用户ID       |
| is_primary | BOOLEAN | NO     | FALSE  | 是否主要作者 |

### 7. 杂志发布者关联表 (magazine_publisher)

| 字段名      | 类型 | 允许空 | 默认值 | 说明   |
| ----------- | ---- | ------ | ------ | ------ |
| magazine_id | INT  | NO     |        | 杂志ID |
| user_id     | INT  | NO     |        | 用户ID |

### 8. 杂志文章关联表 (magazine_article)

| 字段名            | 类型 | 允许空 | 默认值 | 说明   |
| ----------------- | ---- | ------ | ------ | ------ |
| magazine_id       | INT  | NO     |        | 杂志ID |
| article_id        | INT  | NO     |        | 文章ID |
| order_in_magazine | INT  | NO     |        | 排序   |

### 9. 用户关注表 (user_follow)

| 字段名      | 类型     | 允许空 | 默认值            | 说明       |
| ----------- | -------- | ------ | ----------------- | ---------- |
| follower_id | INT      | NO     |                   | 关注者ID   |
| followed_id | INT      | NO     |                   | 被关注者ID |
| created_at  | DATETIME | NO     | CURRENT_TIMESTAMP | 创建时间   |

### 10. 点赞表 (likes)

| 字段名      | 类型     | 允许空 | 默认值            | 说明     |
| ----------- | -------- | ------ | ----------------- | -------- |
| user_id     | INT      | NO     |                   | 用户ID   |
| article_id  | INT      | YES    | NULL              | 文章ID   |
| magazine_id | INT      | YES    | NULL              | 杂志ID   |
| created_at  | DATETIME | NO     | CURRENT_TIMESTAMP | 创建时间 |

### 11. 订阅计划表 (subscription_plan)

| 字段名       | 类型          | 允许空 | 默认值                      | 说明         |
| ------------ | ------------- | ------ | --------------------------- | ------------ |
| id           | INT           | NO     | AUTO_INCREMENT              | 主键         |
| name         | VARCHAR(100)  | NO     |                             | 计划名称     |
| description  | TEXT          | YES    | NULL                        | 描述         |
| price        | DECIMAL(10,2) | NO     |                             | 价格         |
| duration     | INT           | NO     |                             | 有效期(天)   |
| is_recurring | BOOLEAN       | NO     | FALSE                       | 是否自动续费 |
| created_at   | DATETIME      | NO     | CURRENT_TIMESTAMP           | 创建时间     |
| updated_at   | DATETIME      | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间     |

### 12. 支付记录表 (payment)

| 字段名         | 类型                               | 允许空 | 默认值                      | 说明     |
| -------------- | ---------------------------------- | ------ | --------------------------- | -------- |
| id             | INT                                | NO     | AUTO_INCREMENT              | 主键     |
| user_id        | INT                                | NO     |                             | 用户ID   |
| amount         | DECIMAL(10,2)                      | NO     |                             | 金额     |
| payment_method | VARCHAR(50)                        | NO     |                             | 支付方式 |
| transaction_id | VARCHAR(100)                       | YES    | NULL                        | 交易ID   |
| status         | ENUM('success','failed','pending') | NO     |                             | 状态     |
| created_at     | DATETIME                           | NO     | CURRENT_TIMESTAMP           | 创建时间 |
| updated_at     | DATETIME                           | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间 |

### 13. 用户订阅表 (user_subscription)

| 字段名     | 类型                                | 允许空 | 默认值                      | 说明       |
| ---------- | ----------------------------------- | ------ | --------------------------- | ---------- |
| id         | INT                                 | NO     | AUTO_INCREMENT              | 主键       |
| user_id    | INT                                 | NO     |                             | 用户ID     |
| plan_id    | INT                                 | NO     |                             | 计划ID     |
| start_date | DATE                                | NO     |                             | 开始日期   |
| end_date   | DATE                                | NO     |                             | 结束日期   |
| status     | ENUM('active','expired','canceled') | NO     |                             | 状态       |
| payment_id | INT                                 | YES    | NULL                        | 支付记录ID |
| created_at | DATETIME                            | NO     | CURRENT_TIMESTAMP           | 创建时间   |
| updated_at | DATETIME                            | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间   |

### 14. 内容访问规则表 (content_access_rule)

| 字段名               | 类型                                   | 允许空 | 默认值                      | 说明       |
| -------------------- | -------------------------------------- | ------ | --------------------------- | ---------- |
| id                   | INT                                    | NO     | AUTO_INCREMENT              | 主键       |
| content_type         | ENUM('magazine','article','author')    | NO     |                             | 内容类型   |
| content_id           | INT                                    | NO     |                             | 内容ID     |
| access_type          | ENUM('free','subscription','purchase') | NO     |                             | 访问类型   |
| price                | DECIMAL(10,2)                          | YES    | NULL                        | 价格       |
| subscription_plan_id | INT                                    | YES    | NULL                        | 订阅计划ID |
| created_at           | DATETIME                               | NO     | CURRENT_TIMESTAMP           | 创建时间   |
| updated_at           | DATETIME                               | NO     | CURRENT_TIMESTAMP ON UPDATE | 更新时间   |

## ER图

```mermaid
erDiagram
    USER ||--o{ USER_ROLE : "has"
    USER {
        int id PK
        string username
        string password_hash
        string email
        string phone
        string wechat_id
        datetime created_at
        datetime updated_at
    }
    
    ROLE ||--o{ USER_ROLE : "assigned"
    ROLE {
        int id PK
        string name
    }
    
    USER_ROLE }|--|| USER : "user"
    USER_ROLE }|--|| ROLE : "role"
    USER_ROLE {
        int user_id FK
        int role_id FK
    }
    
    ARTICLE ||--o{ ARTICLE_WRITER : "written-by"
    ARTICLE {
        int id PK
        string title
        text content
        string status
        boolean is_premium
        decimal price
        datetime created_at
        datetime updated_at
        int view_count
    }
    
    ARTICLE_WRITER }|--|| USER : "writer"
    ARTICLE_WRITER {
        int article_id FK
        int user_id FK
        boolean is_primary
    }
    
    MAGAZINE ||--o{ MAGAZINE_PUBLISHER : "published-by"
    MAGAZINE {
        int id PK
        string name
        text description
        string cover_image
        boolean is_premium
        int subscription_plan_id FK
        datetime created_at
        datetime updated_at
    }
    
    MAGAZINE_PUBLISHER }|--|| USER : "publisher"
    MAGAZINE_PUBLISHER {
        int magazine_id FK
        int user_id FK
    }
    
    MAGAZINE ||--o{ MAGAZINE_ARTICLE : "contains"
    MAGAZINE_ARTICLE }|--|| ARTICLE : "article"
    MAGAZINE_ARTICLE {
        int magazine_id FK
        int article_id FK
        int order_in_magazine
    }
    
    USER ||--o{ USER_FOLLOW : "follows"
    USER_FOLLOW {
        int follower_id FK
        int followed_id FK
        datetime created_at
    }
    
    USER ||--o{ LIKES : "likes"
    LIKES {
        int user_id FK
        int article_id FK
        int magazine_id FK
        datetime created_at
    }
    
    SUBSCRIPTION_PLAN ||--o{ MAGAZINE : "used-by"
    SUBSCRIPTION_PLAN {
        int id PK
        string name
        text description
        decimal price
        int duration
        boolean is_recurring
        datetime created_at
        datetime updated_at
    }
    
    USER ||--o{ USER_SUBSCRIPTION : "has"
    USER_SUBSCRIPTION }|--|| SUBSCRIPTION_PLAN : "plan"
    USER_SUBSCRIPTION {
        int id PK
        int user_id FK
        int plan_id FK
        date start_date
        date end_date
        string status
        int payment_id FK
        datetime created_at
        datetime updated_at
    }
    
    PAYMENT ||--o{ USER_SUBSCRIPTION : "for"
    PAYMENT {
        int id PK
        int user_id FK
        decimal amount
        string payment_method
        string transaction_id
        string status
        datetime created_at
        datetime updated_at
    }
    
    CONTENT_ACCESS_RULE {
        int id PK
        string content_type
        int content_id
        string access_type
        decimal price
        int subscription_plan_id FK
        datetime created_at
        datetime updated_at
    }
    
    CONTENT_ACCESS_RULE }|--|| SUBSCRIPTION_PLAN : "requires"
```