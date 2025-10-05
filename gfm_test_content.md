# PageJoy Markdown Test Article

Welcome to a comprehensive test of GitHub Flavored Markdown (GFM) features!

## Table of Contents
- [Headers](#headers)
- [Text Formatting](#text-formatting)
- [Lists](#lists)
- [Code](#code)
- [Tables](#tables)
- [Blockquotes](#blockquotes)
- [Links and Images](#links-and-images)
- [Task Lists](#task-lists)

## Headers

# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6

## Text Formatting

This is **bold text**, *italic text*, and ***bold and italic text***.

Strikethrough uses two tildes: ~~Scratch this.~~

## Lists

### Unordered List
- Item 1
- Item 2
  - Sub-item 1
  - Sub-item 2
- Item 3

### Ordered List
1. First item
2. Second item
   1. Sub-item 1
   2. Sub-item 2
3. Third item

### Mixed List
1. First item
   - Sub-item A
   - Sub-item B
2. Second item
   1. Nested sub-item
   2. Another nested sub-item

## Code

Inline `code` has backticks.

### Code Block
```javascript
function helloWorld() {
  console.log("Hello, world!");
  return {
    message: "This is a JavaScript example",
    features: ["syntax highlighting", "code blocks"]
  };
}
```

### Python Example
```python
def fibonacci(n):
    """Generate Fibonacci sequence up to n terms."""
    a, b = 0, 1
    sequence = []
    for _ in range(n):
        sequence.append(a)
        a, b = b, a + b
    return sequence

# Example usage
print(fibonacci(10))
```

## Tables

| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |
| Cell 7   | Cell 8   | Cell 9   |

### Tables with Alignment

| Left-aligned | Center-aligned | Right-aligned |
|:-------------|:--------------:|--------------:|
| git status   |   git status   |   git status  |
| git diff     |   git diff     |   git diff    |

## Blockquotes

> This is a blockquote.
> Multiple lines are supported.
> 
> > You can also nest blockquotes.

## Links and Images

[PageJoy Website](https://pagejoy.com)

![Alt text for image](https://example.com/image.jpg "Optional title")

## Task Lists

- [x] Completed task
- [ ] Incomplete task
- [x] Another completed task
- [ ] Task that needs work

## Horizontal Rules

---

***

___

## More Formatting Examples

Automatic email link: <example@example.com>

GitHub supports many emojis! :sparkles: :camel: :boom:

Inline <mark>highlighted text</mark> (Note: This may not render in all markdown renderers).

### Mixed Content Example

This paragraph contains **bold** text and *italic* text. Here's a [link](https://github.com) and some `inline code`. We can also have ***bold and italic*** text.

> A blockquote can contain multiple elements:
> 
> - Lists
> - `code`
> - **formatting**

```rust
// Code blocks can contain complex examples
fn main() {
    let markdown: &str = "GitHub Flavored Markdown";
    println!("Testing {}", markdown);
}
```

| Feature | Supported | Notes |
|--------|-----------|-------|
| Tables | ✅ | With alignment options |
| Task lists | ✅ | Checkboxes |
| Code blocks | ✅ | With syntax highlighting |
| Strikethrough | ✅ | Using ~~tildes~~ |

1. First ordered item
   - With nested unordered
   - Items
2. Second ordered item
   ```
   Code in lists
   ```
   
> Blockquotes in lists
> Are also supported

## Advanced GFM Features

### Fenced Code Blocks with Language Detection

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

### Tables with Longer Content

| Command | Description |
|---------|-------------|
| `git add` | Adds changes to index |
| `git commit` | Records changes to the repository |
| `git push` | Updates remote refs along with associated objects |

### Complex Table Alignment

| Method | Description | Example |
|:-------|:------------|:--------|
| POST   | Create resource | `POST /api/users` |
| GET    | Read resource | `GET /api/users/1` |
| PUT    | Update resource | `PUT /api/users/1` |
| DELETE | Delete resource | `DELETE /api/users/1` |

### Nested Elements

1. **Main point one**
   - Supporting detail
   - More detail
2. **Main point two**
   > A quote related to the point
   ```javascript
   // Code example
   console.log("Hello GFM!");
   ```
3. **Main point three**
   - [ ] Task related to this point
   
## Conclusion

This comprehensive test covers most GitHub Flavored Markdown features that should render properly in the PageJoy article screen. The implementation should handle headers, text formatting, lists, code blocks, tables, blockquotes, links, images, and task lists with proper styling and functionality.