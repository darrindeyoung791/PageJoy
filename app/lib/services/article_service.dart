import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import '../models/article.dart';
import '../models/favorite.dart';
import 'api_service.dart';

class ArticleService {
  // Flag to simulate offline mode
  static bool _isOffline = true;
  
  static void setOfflineMode(bool offline) {
    _isOffline = offline;
  }
  
  static bool isOffline() {
    return _isOffline;
  }

  // Generate sample articles for offline mode
  static List<Article> generateSampleArticles() {
    final titles = [
      'Flutter 3.0 发布新功能',
      '理解 Dart 空安全',
      '在 Flutter 中构建响应式 UI',
      'Flutter 状态管理：Provider vs Bloc',
      'Flutter Web：技巧和窍门',
      '在 Flutter 中创建自定义动画',
      '测试 Flutter 应用程序',
      'Flutter 性能优化',
      '将 Firebase 与 Flutter 集成',
      '使用 Flutter 构建聊天应用',
      'Flutter Navigation 2.0 详解',
      'Flutter 主题：浅色和深色模式',
      'Flutter 桌面开发入门',
      '在 Flutter 应用中使用 SQLite',
      'Flutter vs React Native 对比',
    ];
    
    final contents = [
      '''# PageJoy Markdown 样式测试

## 二级标题示例

这是一个二级标题，下面是三级和四级标题示例。

### 三级标题

这是三级标题的内容，展示更细粒度的层次结构。

#### 四级标题

这是四级标题的内容，用于更详细的分层。

##### 五级标题

这是五级标题，用于非常详细的分层。

###### 六级标题

这是六级标题，文档中最深层级的标题。

## 文本样式

### 基本文本样式

这是一个**粗体**文本示例，这是一个*斜体*文本示例，这是一个***粗斜体***文本示例。

这是正常段落。我们也可以使用 `inline code` 来展示代码片段。

### 引用样式

> 这是一个普通引用。
> 
> 可以包含多行内容。

>> 这是一个嵌套引用。

>>> 这是一个三级嵌套引用。

### 删除线样式

这是 ~~删除线文本~~ 的示例。

## 代码样式

### 行内代码

这是一个 `行内代码` 示例。

### 代码块示例

```dart
class ArticleScreen extends StatefulWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.article.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(widget.article.content),
      ),
    );
  }
}
```

### 不同语言的代码块

```javascript
function helloWorld() {
  console.log("Hello, World!");
  return {
    message: "This is a JavaScript example",
    features: ["syntax highlighting", "code blocks"]
  };
}
```

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

## 列表样式

### 无序列表

- 项目一
  - 子项目一
    - 孙项目一
    - 孙项目二
  - 子项目二
- 项目二
  1. 有序子列表项
  2. 另一个有序子列表项
- 项目三

### 有序列表

1. 第一步
   - 可以在有序列表中嵌入无序列表
   - 继续嵌入项
2. 第二步
   1. 嵌套有序列表
   2. 继续嵌套
3. 第三步

### 混合列表

1. 主要步骤
   - 子任务 a
   - 子任务 b
2. 另一个主要步骤
   ```bash
   # 代码块在列表中
   echo "Hello World"
   ```

## 表格样式

### 基础表格

| 姓名 | 年龄 | 职业 |
|------|------|------|
| 张三 | 25   | 工程师 |
| 李四 | 30   | 设计师 |
| 王五 | 28   | 产品经理 |

### 对齐表格

| 左对齐 | 居中对齐 | 右对齐 |
|:-------|:--------:|-------:|
| 左     |   居中   |      右|
| 内容   |   内容   |   内容 |
| 更多   |   内容   |   右对齐 |

### 复杂表格

| 序号 | 项目 | 完成度 | 说明 |
|------|------|--------|------|
| 1 | 需求分析 | ✅ | 完成 | 
| 2 | UI设计 | 🔄 | 进行中 |
| 3 | 开发 | ❌ | 待开始 |
| 4 | 测试 | ❌ | 待开始 |

## 任务列表

- [x] 完成需求分析
- [x] 设计系统架构
- [ ] 实现核心功能
- [ ] 进行测试
- [ ] 发布上线
- [x] 编写文档
  - [x] API文档
  - [ ] 用户手册

## 分隔线

这是一个分隔线的示例：

---

这是分隔线下面的内容。

***

这是星号分隔线。

___

这是下划线分隔线。

## 链接和图片

这是一个 [示例链接](https://example.com)。

也可以使用自动链接 <https://example.com>。

## 图片示例

这里有一个图片，独占一行：

![示例图片](https://cn.bing.com/rp/Q0pzSymUNRwlfDJ3G2rxwANmBnc.png "示例图片标题")

这是图片下方的内容，用来测试图片是否正确独占一行。

## 高级样式

### 混合内容

这是一个段落，其中包含 `代码`、**粗体**、*斜体* 和 [链接](https://example.com)。

> 这是一个包含 `代码` 的引用
> 
> 以及**粗体文本**

1. 列表项包含 `代码`
   - 还可以包含 [链接](https://example.com)
   - 以及**粗体文本**
   ```dart
   // 代码块
   print("Hello");
   ```

## 表情和特殊符号

这是一个 :smile: 表情。其他常用表情：

- :+1: 表示赞同
- :heart: 表示喜欢
- :rocket: 表示发射
- :tada: 表示庆祝

特殊符号: © ® ™ § ¶ † ‡ • · … ′ ″

## 表格与代码混合

| 命令 | 描述 | 示例 |
|------|------|------|
| `flutter create` | 创建新项目 | `flutter create my_app` |
| `flutter run` | 运行应用 | `flutter run` |
| `flutter build` | 构建应用 | `flutter build apk` |
''',

      '''# Flutter 3.0 新特性详解

![Flutter Banner](https://cn.bing.com/rp/Q0pzSymUNRwlfDJ3G2rxwANmBnc.png)

Flutter 3.0 带来了许多令人兴奋的新特性和改进。Performance improvements include better shader compilation and reduced app startup time. The new Material 3 (Material You) design system is now available by default.

## 主要特性

![Material Design](https://cn.bing.com/rp/Q0pzSymUNRwlfDJ3G2rxwANmBnc.png)

Key Features:
1. Casual gaming toolkit
2. Enhanced platform adaptability
3. Improved font rendering
4. Better desktop support

这次更新还优化了在不同平台上的表现，特别是在桌面端的支持更加完善。开发者现在可以更容易地创建跨平台应用，同时保持较高的性能和用户体验。

Flutter 3.0 引入了新的开发工具和功能，进一步提升了开发体验。开发人员可以利用这些新工具更快地构建高质量的应用程序。新版本还改进了对 Web 和桌面平台的支持，使得跨平台开发变得更加顺畅。

## 性能优化

![Performance Chart](https://cn.bing.com/rp/Q0pzSymUNRwlfDJ3G2rxwANmBnc.png)

对于移动应用开发，Flutter 3.0 带来了更好的性能优化和更低的内存占用。这使得应用程序运行更加流畅，用户体验得到了显著提升。同时，新版本还增加了对更多设备和屏幕尺寸的适配支持。

## 代码示例

```dart
class Flutter3Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 3.0 Example',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter 3.0')),
        body: Center(child: Text('Hello Flutter 3.0!')),
      ),
    );
  }
}
```

## 总结

![Flutter Logo](https://cn.bing.com/rp/Q0pzSymUNRwlfDJ3G2rxwANmBnc.png)

新版本还增加了对更多设备和屏幕尺寸的适配支持。
''',

      '''Dart null safety 是一个重要的语言特性，它帮助开发者在编译时就能发现潜在的空指针错误。

Understanding the Basics:
- Non-nullable by default
- The ? operator
- Late variables
- The ! operator

空安全不仅提高了代码的可靠性，还能帮助优化运行时性能。通过静态分析，编译器可以移除不必要的空检查，使代码运行更快。这个特性现在已经成为 Dart 语言的标配。

在实际开发中，空安全能够显著减少运行时错误，提高应用的稳定性。开发者可以通过合理使用可空类型和非空类型，构建更加健壮的应用程序。同时，空安全也有助于提高代码的可读性和维护性。

为了更好地利用空安全特性，开发者需要理解其核心概念并遵循最佳实践。这包括正确使用类型注解、避免不必要的强制解包操作，以及合理处理可空值的情况。
''',

      '''响应式编程是 Flutter 的核心概念之一。Understanding how to build reactive UIs is crucial for Flutter development。

Key Concepts:
1. Widget Tree
2. State Management
3. BuildContext
4. setState()

在 Flutter 中，一切都是 Widget，而 State 对象则负责管理 Widget 的状态。当状态发生变化时，Flutter 框架会自动重建受影响的界面部分，确保用户界面始终反映最新的应用状态。这种响应式的特性使得 Flutter 应用开发变得更加直观和高效。

响应式编程模型使得应用能够自动响应数据变化，无需手动更新界面。这大大简化了复杂界面的开发工作，提高了开发效率。同时，Flutter 的响应式机制还能确保界面更新的性能，避免不必要的重绘操作。

通过合理使用 Flutter 的响应式特性，开发者可以构建出流畅、高效的用户界面。这包括正确管理组件状态、优化构建函数的执行，以及合理使用各种 Widget 类型来实现所需的界面效果。
''',

      '''Flutter 中有多种状态管理解决方案，每种都有其适用场景。Provider vs BLoC comparison：

Provider：
- Simple and lightweight
- Great for small to medium apps
- Easy learning curve

BLoC：
- Powerful and scalable
- Suitable for large applications
- Better separation of concerns

选择合适的状态管理方案需要考虑项目规模、团队经验和具体需求。在小型项目中，Provider 通常是更好的选择；而在大型项目中，BLoC 的优势则更为明显。

除了 Provider 和 BLoC 之外，Flutter 还支持其他状态管理方案，如 Redux、MobX 等。每种方案都有其特点和适用场景，开发者需要根据项目需求进行选择。

在实际开发中，状态管理不仅涉及数据的存储和更新，还包括组件之间的通信和数据流的控制。合理选择和使用状态管理方案，可以显著提高应用的可维护性和扩展性。
''',

      '''Flutter Web 开发有其独特的注意事项和优化技巧。

Optimization Tips：
1. Asset preloading
2. Code splitting
3. Performance profiling
4. SEO considerations

在 Web 平台上，Flutter 应用需要特别注意首次加载时间和性能优化。通过合理的代码分割和资源预加载，可以显著提升用户体验。同时，还需要考虑搜索引擎优化（SEO）的需求，确保应用能够被搜索引擎正确索引。

Web 平台的性能优化涉及多个方面，包括资源压缩、缓存策略、网络请求优化等。开发者需要综合考虑这些因素，以提供最佳的用户体验。

为了提高 Flutter Web 应用的性能，开发者可以使用各种工具和技术进行分析和优化。这包括使用性能分析工具识别瓶颈，以及采用最佳实践来改进应用的加载速度和运行效率。
''',

      '''在 Flutter 中创建自定义动画可以极大地增强应用的用户体验。Animations in Flutter are powerful and flexible。

基本动画类型：
1. 隐式动画（Implicit Animations）
2. 显式动画（Explicit Animations）
3. 过渡动画（Tween Animations）

通过使用 AnimatedWidget 和 AnimationController，开发者可以轻松创建复杂的动画效果。这些动画不仅可以应用于界面元素的转换，还可以用于页面之间的切换，提升应用的流畅度和美观性。

动画设计需要考虑用户体验和性能平衡。过度或不当的动画可能会分散用户注意力或影响应用性能，因此需要合理使用。

在实现动画时，开发者应该关注动画的流畅性和自然性。这包括选择合适的动画曲线、控制动画时长，以及确保动画与应用的整体设计风格保持一致。
''',

      '''测试是确保 Flutter 应用质量的关键环节。Flutter 提供了丰富的测试框架和工具。

测试类型：
1. 单元测试（Unit Tests）
2. 小部件测试（Widget Tests）
3. 集成测试（Integration Tests）

通过使用 Flutter 的测试工具，开发者可以对应用的各个层面进行全面的测试。这不仅包括逻辑和算法的正确性，还包括用户界面的表现和交互的流畅性。良好的测试覆盖率可以显著降低应用发布后的问题率。

测试驱动开发（TDD）是一种有效的开发方法，可以帮助开发者在编写代码之前就考虑清楚需求和实现方案。

自动化测试不仅可以提高代码质量，还能减少回归错误的风险。通过建立完善的测试体系，团队可以更自信地进行代码重构和功能迭代。
''',

      '''性能优化是 Flutter 开发中不可或缺的一部分。通过合理的优化策略，可以大幅提升应用的运行效率。

优化建议：
1. 减少重绘（Repaint）区域
2. 使用 const 构造函数
3. 图片和资源的懒加载
4. 避免不必要的 setState() 调用

通过使用 Flutter 提供的性能分析工具，开发者可以直观地看到应用的性能瓶颈，并针对性地进行优化。这不仅能提升应用的响应速度，还能降低能耗，延长用户设备的电池寿命。

性能优化是一个持续的过程，需要在开发的各个阶段都给予关注。通过定期进行性能测试和分析，可以确保应用始终保持良好的性能表现。

在进行性能优化时，开发者应该优先解决影响用户体验最严重的问题，然后逐步优化其他方面。这样可以确保优化工作的投入产出比最大化。
''',

      '''将 Firebase 与 Flutter 集成可以为应用增加强大的后端支持。Firebase 提供了实时数据库、身份验证、云存储等多种服务。

集成步骤：
1. 添加 Firebase SDK
2. 配置 Firebase 项目
3. 使用 FlutterFire 插件

通过使用 Firebase，开发者可以轻松实现用户认证、数据存储和推送通知等功能。这些功能的实现大大简化了应用的后端开发工作，让开发者可以将更多精力集中在应用的业务逻辑和用户体验上。

Firebase 不仅提供了丰富的后端服务，还具有良好的可扩展性和可靠性。这使得它成为许多 Flutter 应用的首选后端解决方案。

在使用 Firebase 时，开发者需要注意数据安全和隐私保护。通过合理配置安全规则和权限控制，可以确保应用数据的安全性。
''',

      '''使用 Flutter 构建聊天应用是展示其强大 UI 能力的一个绝佳案例。

关键技术：
1. WebSocket 实时通信
2. 聊天记录的本地存储
3. 消息推送通知

通过合理使用 Flutter 的状态管理和网络请求库，开发者可以快速构建出一个功能完善的聊天应用。这不仅包括基本的消息发送和接收，还可以实现消息的撤回、编辑和多媒体文件的发送等高级功能。

聊天应用的开发涉及多个技术领域，包括实时通信、数据存储、用户界面设计等。开发者需要综合考虑这些因素，以提供最佳的用户体验。

为了提高聊天应用的性能和稳定性，开发者需要关注网络连接的处理、消息的同步机制，以及用户界面的响应速度等方面。
''',

      '''Flutter Navigation 2.0 带来了更加强大和灵活的路由管理能力。

新特性：
1. 基于路由的导航
2. 支持命名路由和动态路由
3. 路由守卫（Route Guards）

通过使用 Navigator 2.0，开发者可以更加精细地控制应用的导航行为。这包括对路由的动态添加、移除和替换，以及对路由访问的权限控制等。这样的灵活性使得 Flutter 应用能够更好地适应复杂的业务需求。

Navigation 2.0 的设计理念是将路由状态与应用状态解耦，使得路由管理更加清晰和可控。

通过合理使用 Navigation 2.0 的特性，开发者可以构建出结构清晰、易于维护的应用导航系统。这对于大型应用尤为重要。
''',

      '''Flutter 主题系统支持应用的全局和局部主题定制。

主题定制：
1. 全局主题（MaterialApp.theme）
2. 局部主题（Theme.of(context)）
3. 动态主题切换

通过使用 ThemeData，开发者可以轻松定义应用的色彩、字体和形状等视觉属性。这不仅可以提升应用的美观性，还能增强品牌识别度。同时，Flutter 还支持在运行时动态切换主题，极大地方便了开发者实现用户个性化定制的需求。

主题系统不仅影响应用的外观，还关系到用户体验的一致性。通过合理设计和使用主题，可以提升应用的专业性和用户满意度。

在实现主题切换功能时，开发者需要考虑状态管理和数据持久化等问题，以确保用户的选择能够被正确保存和应用。
''',

      '''Flutter 桌面支持让开发者可以使用 Flutter 构建跨平台的桌面应用。

桌面支持特性：
1. 原生窗口和菜单
2. 拖放文件支持
3. 系统托盘图标

通过使用 Flutter 的桌面支持，开发者可以用一套代码同时构建 Windows、macOS 和 Linux 平台的应用。这不仅提高了开发效率，还能确保应用在不同平台上的一致性和稳定性。

桌面应用开发需要考虑与操作系统特性的集成，以及不同平台间的差异处理。

为了提供更好的桌面用户体验，开发者需要关注应用的性能、界面设计和交互方式等方面，使其更符合桌面用户的使用习惯。
''',

      '''在 Flutter 应用中使用 SQLite 可以实现高效的本地数据存储。

使用步骤：
1. 添加 sqflite 插件
2. 打开数据库
3. 执行 CRUD 操作

通过使用 SQLite，开发者可以轻松实现应用数据的持久化存储。这对于需要离线支持的应用尤为重要。结合 Flutter 的异步编程模型，使用 SQLite 进行数据存储的操作可以做到高效而不阻塞主线程。

数据库设计需要考虑数据结构的合理性、查询效率以及数据一致性等问题。

在使用 SQLite 时，开发者还需要关注数据库的版本管理和迁移策略，以确保应用升级时数据的兼容性。
''',

      '''Flutter 和 React Native 是当前最流行的两种跨平台移动应用开发框架。

对比分析：
1. 性能：Flutter 更接近原生，React Native 依赖于桥接
2. 开发效率：Flutter 热重载更快，React Native 生态成熟
3. 社区支持：React Native 社区更大，Flutter 发展迅速

选择合适的框架需要根据项目需求、团队技术栈和长期维护成本等多方面考虑。在对性能要求极高的项目中，Flutter 可能是更好的选择；而在需要快速迭代和广泛社区支持的项目中，React Native 则具有优势。

两种框架都有各自的优势和适用场景，开发者需要根据具体情况进行选择。

随着技术的不断发展，两种框架都在持续改进和完善，为开发者提供更好的开发体验和更强大的功能支持。
''',
    ];
    
    // AI摘要示例
    final aiSummaries = [
      'Flutter 3.0 发布了许多新特性和改进，包括更好的着色器编译、减少应用启动时间以及默认提供的 Material 3 设计系统。新版本还增强了在不同平台上的表现，特别是在桌面端的支持更加完善。',
      'Dart 空安全是一个重要的语言特性，它帮助开发者在编译时发现潜在的空指针错误。通过静态分析，编译器可以移除不必要的空检查，使代码运行更快，同时提高代码的可靠性和可维护性。',
      '响应式编程是 Flutter 的核心概念之一。在 Flutter 中，一切都是 Widget，而 State 对象负责管理 Widget 的状态。当状态发生变化时，Flutter 框架会自动重建受影响的界面部分，确保用户界面始终反映最新的应用状态。',
      'Flutter 提供了多种状态管理解决方案，包括 Provider 和 BLoC。Provider 简单轻量，适合中小型应用；BLoC 功能强大且可扩展，适合大型应用。选择合适的状态管理方案需要考虑项目规模、团队经验和具体需求。',
      'Flutter Web 开发需要注意首次加载时间和性能优化。通过合理的代码分割和资源预加载，可以显著提升用户体验。同时，还需要考虑搜索引擎优化（SEO）的需求，确保应用能够被搜索引擎正确索引。',
      '在 Flutter 中创建自定义动画可以极大地增强应用的用户体验。通过使用 AnimatedWidget 和 AnimationController，开发者可以轻松创建复杂的动画效果。动画设计需要考虑用户体验和性能平衡。',
      '测试是确保 Flutter 应用质量的关键环节。Flutter 提供了丰富的测试框架和工具，包括单元测试、小部件测试和集成测试。通过使用这些工具，开发者可以对应用的各个层面进行全面的测试。',
      '性能优化是 Flutter 开发中不可或缺的一部分。通过减少重绘区域、使用 const 构造函数、懒加载图片和资源，以及避免不必要的 setState() 调用，可以大幅提升应用的运行效率。',
      '将 Firebase 与 Flutter 集成可以为应用增加强大的后端支持。Firebase 提供了实时数据库、身份验证、云存储等多种服务。通过使用 Firebase，开发者可以轻松实现用户认证、数据存储和推送通知等功能。',
      '使用 Flutter 构建聊天应用需要考虑 WebSocket 实时通信、聊天记录的本地存储和消息推送通知等关键技术。通过合理使用 Flutter 的状态管理和网络请求库，可以快速构建出功能完善的聊天应用。',
      'Flutter Navigation 2.0 带来了更加强大和灵活的路由管理能力，包括基于路由的导航、命名路由和动态路由支持，以及路由守卫功能。这使得 Flutter 应用能够更好地适应复杂的业务需求。',
      'Flutter 主题系统支持应用的全局和局部主题定制，包括全局主题、局部主题和动态主题切换。通过使用 ThemeData，开发者可以轻松定义应用的色彩、字体和形状等视觉属性。',
      'Flutter 桌面支持让开发者可以用一套代码同时构建 Windows、macOS 和 Linux 平台的应用。这不仅提高了开发效率，还能确保应用在不同平台上的一致性和稳定性。',
      '在 Flutter 应用中使用 SQLite 可以实现高效的本地数据存储。通过使用 SQLite，开发者可以轻松实现应用数据的持久化存储，这对于需要离线支持的应用尤为重要。',
      'Flutter 和 React Native 是当前最流行的两种跨平台移动应用开发框架。Flutter 更接近原生，性能更好；React Native 生态成熟，社区支持更大。选择合适的框架需要根据项目需求和团队技术栈进行考虑。',
    ];
    
    final random = Random();
    final articles = <Article>[];
    
    for (int i = 0; i < 20; i++) {
      articles.add(
        Article(
          id: i + 1,
          title: titles[random.nextInt(titles.length)],
          content: contents[random.nextInt(contents.length)],
          aiSummary: aiSummaries[random.nextInt(aiSummaries.length)], // 添加AI摘要
          status: 'published',
          isPremium: random.nextBool(),
          price: random.nextBool() ? 9.99 : null,
          createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
          updatedAt: DateTime.now().subtract(Duration(hours: random.nextInt(24))),
          viewCount: random.nextInt(1000),
        ),
      );
    }
    
    return articles;
  }

  static Future<Article> createArticle(Map<String, dynamic> articleData) async {
    if (_isOffline) {
      throw Exception('离线模式下无法创建文章');
    }
    
    final response = await ApiService.post('/articles/', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('创建文章失败');
    }
  }

  static Future<Article> getArticle(int articleId) async {
    if (_isOffline) {
      // In offline mode, return a sample article
      final sampleArticles = generateSampleArticles();
      return sampleArticles.firstWhere(
        (article) => article.id == articleId,
        orElse: () => sampleArticles[0],
      );
    }
    
    final response = await ApiService.get('/articles/$articleId');
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('加载文章失败');
    }
  }

  static Future<List<Article>> getArticles({int skip = 0, int limit = 100}) async {
    if (_isOffline) {
      // In offline mode, return sample articles
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      final sampleArticles = generateSampleArticles();
      final endIndex = (skip + limit).clamp(0, sampleArticles.length);
      return sampleArticles.sublist(skip, endIndex);
    }
    
    final response = await ApiService.get('/articles/?skip=$skip&limit=$limit');
    
    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body);
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('加载文章失败');
    }
  }

  static Future<Article> updateArticle(int articleId, Map<String, dynamic> articleData) async {
    if (_isOffline) {
      throw Exception('离线模式下无法更新文章');
    }
    
    final response = await ApiService.put('/articles/$articleId', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('更新文章失败');
    }
  }

  static Future<void> deleteArticle(int articleId) async {
    if (_isOffline) {
      throw Exception('离线模式下无法删除文章');
    }
    
    final response = await ApiService.delete('/articles/$articleId');
    
    if (response.statusCode != 200) {
      throw Exception('删除文章失败');
    }
  }

  // 收藏相关的方法
  static Future<Favorite> createFavorite(int userId, {int? articleId, int? magazineId}) async {
    if (_isOffline) {
      throw Exception('离线模式下无法收藏');
    }
    
    final response = await ApiService.post('/favorites/', {
      'user_id': userId,
      'article_id': articleId,
      'magazine_id': magazineId,
    });
    
    if (response.statusCode == 200) {
      return Favorite.fromJson(json.decode(response.body));
    } else {
      throw Exception('收藏失败');
    }
  }

  static Future<void> deleteFavorite(int userId, String contentType, int contentId) async {
    if (_isOffline) {
      throw Exception('离线模式下无法取消收藏');
    }
    
    final response = await ApiService.delete('/favorites/$userId/$contentType/$contentId');
    
    if (response.statusCode != 200) {
      throw Exception('取消收藏失败');
    }
  }

  static Future<List<Article>> getUserFavoriteArticles(int userId) async {
    if (_isOffline) {
      // 在离线模式下返回一些示例收藏文章
      final allArticles = generateSampleArticles();
      // 返回其中的一部分作为收藏示例（前10个，或全部如果少于10个）
      return allArticles.take(10).toList();
    }
    
    final response = await ApiService.get('/favorites/user/$userId/articles');
    
    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body);
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('加载收藏文章失败');
    }
  }

  static Future<bool> isArticleFavorited(int userId, int articleId) async {
    if (_isOffline) {
      // 离线模式下默认返回未收藏
      return false;
    }
    
    try {
      final response = await ApiService.get('/favorites/$userId/article/$articleId');
      return response.statusCode == 200;
    } catch (e) {
      // 如果请求失败（例如404），则表示未收藏
      return false;
    }
  }

  // GFM Test Methods
  static Future<String> loadGfmTestContent() async {
    try {
      return await rootBundle.loadString('assets/test_content/gfm_test_content.md');
    } catch (e) {
      print('Error loading GFM test content: $e');
      return '# Error\n\nFailed to load test content.';
    }
  }

  static Future<Article> getGfmTestArticle() async {
    final content = await loadGfmTestContent();
    return Article(
      id: 999,
      title: 'GFM Test Article',
      content: content,
      aiSummary: 'This is a test article containing various GFM (GitHub Flavored Markdown) elements to verify proper rendering in the PageJoy app.',
      status: 'published',
      isPremium: false,
      price: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      viewCount: 0,
    );
  }
}