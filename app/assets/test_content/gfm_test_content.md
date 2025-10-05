# PageJoy Markdown 测试文章

欢迎来到 GitHub 风格 Markdown（GFM）功能的综合测试！

## 目录

[toc]

## 标题

# 标题 1
## 标题 2
### 标题 3
#### 标题 4
##### 标题 5
###### 标题 6

## 文本格式

这是**粗体文本**，*斜体文本*，以及***粗体和斜体文本***。

删除线使用两个波浪号：~~划掉这个。~~

## 列表

### 无序列表
- 项目 1
- 项目 2
  - 子项目 1
  - 子项目 2
- 项目 3

### 有序列表
1. 第一项
2. 第二项
   1. 子项目 1
   2. 子项目 2
3. 第三项

### 混合列表
1. 第一项
   - 子项目 A
   - 子项目 B
2. 第二项
   1. 嵌套子项目
   2. 另一个嵌套子项目

## 代码

行内 `代码` 使用反引号。

### 代码块
```javascript
function helloWorld() {
  console.log("你好，世界！");
  return {
    message: "这是 JavaScript 示例",
    features: ["语法高亮", "代码块"]
  };
}
```

### Python 示例
```python
def fibonacci(n):
    """生成斐波那契数列的前 n 项。"""
    a, b = 0, 1
    sequence = []
    for _ in range(n):
        sequence.append(a)
        a, b = b, a + b
    return sequence

# 示例用法
print(fibonacci(10))
```

## 表格

| 表头 1 | 表头 2 | 表头 3 |
|----------|----------|----------|
| 单元格 1   | 单元格 2   | 单元格 3   |
| 单元格 4   | 单元格 5   | 单元格 6   |
| 单元格 7   | 单元格 8   | 单元格 9   |

### 带对齐的表格

| 左对齐 | 居中对齐 | 右对齐 |
|:-------------|:--------------:|--------------:|
| git status   |   git status   |   git status  |
| git diff     |   git diff     |   git diff    |

## 引用

> 这是一个引用。
> 支持多行。
> 
> > 你也可以嵌套引用。

## 链接和图片

[示例网站](https://www.example.com )

![图片的替代文字](https://cn.bing.com/rp/Q0pzSymUNRwlfDJ3G2rxwANmBnc.png  "可选标题")

## 任务列表

- [x] 已完成的任务
- [ ] 未完成的任务
- [x] 另一个已完成的任务
- [ ] 需要完成的任务

## 水平线

---

***

___

## 更多格式示例

自动邮箱链接：<example@example.com>

GitHub 支持许多表情符号！:sparkles: :camel: :boom:

行内 <mark>高亮文本</mark>（注意：这可能不会在所有 Markdown 渲染器中显示）。

### 混合内容示例

这个段落包含**粗体**文本和*斜体*文本。这里有一个[链接](https://github.com )和一些`行内代码`。我们还可以有***粗体和斜体***文本。

> 引用可以包含多个元素：
> 
> - 列表
> - `代码`
> - **格式**

```rust
// 代码块可以包含复杂示例
fn main() {
    let markdown: &str = "GitHub 风格 Markdown";
    println!("测试 {}", markdown);
}
```

| 功能 | 支持 | 备注 |
|--------|-----------|-------|
| 表格 | ✅ | 带对齐选项 |
| 任务列表 | ✅ | 复选框 |
| 代码块 | ✅ | 带语法高亮 |
| 删除线 | ✅ | 使用 ~~波浪号~~ |

1. 第一个有序项目
   - 带嵌套无序
   - 项目
2. 第二个有序项目
   ```
   列表中的代码
   ```
   
> 列表中的引用
> 也支持

## 高级 GFM 功能

### 带语言检测的围栏代码块

```yaml
name: Build
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Run tests
      run: |
        echo "Running tests..."
```

### 带较长内容的表格

| 命令 | 描述 |
|---------|-------------|
| `git add` | 添加更改到索引 |
| `git commit` | 记录更改到仓库 |
| `git push` | 更新远程引用及相关对象 |

### 复杂表格对齐

| 方法 | 描述 | 示例 |
|:-------|:------------|:--------|
| POST   | 创建资源 | `POST /api/users` |
| GET    | 读取资源 | `GET /api/users/1` |
| PUT    | 更新资源 | `PUT /api/users/1` |
| DELETE | 删除资源 | `DELETE /api/users/1` |

### 嵌套元素

1. **主要点一**
   - 支持细节
   - 更多细节
2. **主要点二**
   > 与该点相关的引用
   ```javascript
   // 代码示例
   console.log("你好，GFM！");
   ```
3. **主要点三**
   - [ ] 与此点相关的任务
