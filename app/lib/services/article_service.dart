import 'dart:convert';
import 'dart:math';
import '../models/article.dart';
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
      'Flutter 3.0 带来了许多令人兴奋的新特性和改进。Performance improvements include better shader compilation and reduced app startup time. The new Material 3 (Material You) design system is now available by default.\n\nKey Features:\n1. Casual gaming toolkit\n2. Enhanced platform adaptability\n3. Improved font rendering\n4. Better desktop support\n\n这次更新还优化了在不同平台上的表现，特别是在桌面端的支持更加完善。开发者现在可以更容易地创建跨平台应用，同时保持较高的性能和用户体验。\n\nFlutter 3.0 引入了新的开发工具和功能，进一步提升了开发体验。开发人员可以利用这些新工具更快地构建高质量的应用程序。新版本还改进了对 Web 和桌面平台的支持，使得跨平台开发变得更加顺畅。\n\n对于移动应用开发，Flutter 3.0 带来了更好的性能优化和更低的内存占用。这使得应用程序运行更加流畅，用户体验得到了显著提升。同时，新版本还增加了对更多设备和屏幕尺寸的适配支持。',

      'Dart null safety 是一个重要的语言特性，它帮助开发者在编译时就能发现潜在的空指针错误。\n\nUnderstanding the Basics:\n- Non-nullable by default\n- The ? operator\n- Late variables\n- The ! operator\n\n空安全不仅提高了代码的可靠性，还能帮助优化运行时性能。通过静态分析，编译器可以移除不必要的空检查，使代码运行更快。这个特性现在已经成为 Dart 语言的标配。\n\n在实际开发中，空安全能够显著减少运行时错误，提高应用的稳定性。开发者可以通过合理使用可空类型和非空类型，构建更加健壮的应用程序。同时，空安全也有助于提高代码的可读性和维护性。\n\n为了更好地利用空安全特性，开发者需要理解其核心概念并遵循最佳实践。这包括正确使用类型注解、避免不必要的强制解包操作，以及合理处理可空值的情况。',

      '响应式编程是 Flutter 的核心概念之一。Understanding how to build reactive UIs is crucial for Flutter development.\n\nKey Concepts:\n1. Widget Tree\n2. State Management\n3. BuildContext\n4. setState()\n\n在 Flutter 中，一切都是 Widget，而 State 对象则负责管理 Widget 的状态。当状态发生变化时，Flutter 框架会自动重建受影响的界面部分，确保用户界面始终反映最新的应用状态。这种响应式的特性使得 Flutter 应用开发变得更加直观和高效。\n\n响应式编程模型使得应用能够自动响应数据变化，无需手动更新界面。这大大简化了复杂界面的开发工作，提高了开发效率。同时，Flutter 的响应式机制还能确保界面更新的性能，避免不必要的重绘操作。\n\n通过合理使用 Flutter 的响应式特性，开发者可以构建出流畅、高效的用户界面。这包括正确管理组件状态、优化构建函数的执行，以及合理使用各种 Widget 类型来实现所需的界面效果。',

      'Flutter 中有多种状态管理解决方案，每种都有其适用场景。Provider vs BLoC comparison:\n\nProvider:\n- Simple and lightweight\n- Great for small to medium apps\n- Easy learning curve\n\nBLoC:\n- Powerful and scalable\n- Suitable for large applications\n- Better separation of concerns\n\n选择合适的状态管理方案需要考虑项目规模、团队经验和具体需求。在小型项目中，Provider 通常是更好的选择；而在大型项目中，BLoC 的优势则更为明显。\n\n除了 Provider 和 BLoC 之外，Flutter 还支持其他状态管理方案，如 Redux、MobX 等。每种方案都有其特点和适用场景，开发者需要根据项目需求进行选择。\n\n在实际开发中，状态管理不仅涉及数据的存储和更新，还包括组件之间的通信和数据流的控制。合理选择和使用状态管理方案，可以显著提高应用的可维护性和扩展性。',

      'Flutter Web 开发有其独特的注意事项和优化技巧。\n\nOptimization Tips:\n1. Asset preloading\n2. Code splitting\n3. Performance profiling\n4. SEO considerations\n\n在 Web 平台上，Flutter 应用需要特别注意首次加载时间和性能优化。通过合理的代码分割和资源预加载，可以显著提升用户体验。同时，还需要考虑搜索引擎优化（SEO）的需求，确保应用能够被搜索引擎正确索引。\n\nWeb 平台的性能优化涉及多个方面，包括资源压缩、缓存策略、网络请求优化等。开发者需要综合考虑这些因素，以提供最佳的用户体验。\n\n为了提高 Flutter Web 应用的性能，开发者可以使用各种工具和技术进行分析和优化。这包括使用性能分析工具识别瓶颈，以及采用最佳实践来改进应用的加载速度和运行效率。',

      '在 Flutter 中创建自定义动画可以极大地增强应用的用户体验。Animations in Flutter are powerful and flexible.\n\n基本动画类型：\n1. 隐式动画（Implicit Animations）\n2. 显式动画（Explicit Animations）\n3. 过渡动画（Tween Animations）\n\n通过使用 AnimatedWidget 和 AnimationController，开发者可以轻松创建复杂的动画效果。这些动画不仅可以应用于界面元素的转换，还可以用于页面之间的切换，提升应用的流畅度和美观性。\n\n动画设计需要考虑用户体验和性能平衡。过度或不当的动画可能会分散用户注意力或影响应用性能，因此需要合理使用。\n\n在实现动画时，开发者应该关注动画的流畅性和自然性。这包括选择合适的动画曲线、控制动画时长，以及确保动画与应用的整体设计风格保持一致。',

      '测试是确保 Flutter 应用质量的关键环节。Flutter 提供了丰富的测试框架和工具。\n\n测试类型：\n1. 单元测试（Unit Tests）\n2. 小部件测试（Widget Tests）\n3. 集成测试（Integration Tests）\n\n通过使用 Flutter 的测试工具，开发者可以对应用的各个层面进行全面的测试。这不仅包括逻辑和算法的正确性，还包括用户界面的表现和交互的流畅性。良好的测试覆盖率可以显著降低应用发布后的问题率。\n\n测试驱动开发（TDD）是一种有效的开发方法，可以帮助开发者在编写代码之前就考虑清楚需求和实现方案。\n\n自动化测试不仅可以提高代码质量，还能减少回归错误的风险。通过建立完善的测试体系，团队可以更自信地进行代码重构和功能迭代。',

      '性能优化是 Flutter 开发中不可或缺的一部分。通过合理的优化策略，可以大幅提升应用的运行效率。\n\n优化建议：\n1. 减少重绘（Repaint）区域\n2. 使用 const 构造函数\n3. 图片和资源的懒加载\n4. 避免不必要的 setState() 调用\n\n通过使用 Flutter 提供的性能分析工具，开发者可以直观地看到应用的性能瓶颈，并针对性地进行优化。这不仅能提升应用的响应速度，还能降低能耗，延长用户设备的电池寿命。\n\n性能优化是一个持续的过程，需要在开发的各个阶段都给予关注。通过定期进行性能测试和分析，可以确保应用始终保持良好的性能表现。\n\n在进行性能优化时，开发者应该优先解决影响用户体验最严重的问题，然后逐步优化其他方面。这样可以确保优化工作的投入产出比最大化。',

      '将 Firebase 与 Flutter 集成可以为应用增加强大的后端支持。Firebase 提供了实时数据库、身份验证、云存储等多种服务。\n\n集成步骤：\n1. 添加 Firebase SDK\n2. 配置 Firebase 项目\n3. 使用 FlutterFire 插件\n\n通过使用 Firebase，开发者可以轻松实现用户认证、数据存储和推送通知等功能。这些功能的实现大大简化了应用的后端开发工作，让开发者可以将更多精力集中在应用的业务逻辑和用户体验上。\n\nFirebase 不仅提供了丰富的后端服务，还具有良好的可扩展性和可靠性。这使得它成为许多 Flutter 应用的首选后端解决方案。\n\n在使用 Firebase 时，开发者需要注意数据安全和隐私保护。通过合理配置安全规则和权限控制，可以确保应用数据的安全性。',

      '使用 Flutter 构建聊天应用是展示其强大 UI 能力的一个绝佳案例。\n\n关键技术：\n1. WebSocket 实时通信\n2. 聊天记录的本地存储\n3. 消息推送通知\n\n通过合理使用 Flutter 的状态管理和网络请求库，开发者可以快速构建出一个功能完善的聊天应用。这不仅包括基本的消息发送和接收，还可以实现消息的撤回、编辑和多媒体文件的发送等高级功能。\n\n聊天应用的开发涉及多个技术领域，包括实时通信、数据存储、用户界面设计等。开发者需要综合考虑这些因素，以提供最佳的用户体验。\n\n为了提高聊天应用的性能和稳定性，开发者需要关注网络连接的处理、消息的同步机制，以及用户界面的响应速度等方面。',

      'Flutter Navigation 2.0 带来了更加强大和灵活的路由管理能力。\n\n新特性：\n1. 基于路由的导航\n2. 支持命名路由和动态路由\n3. 路由守卫（Route Guards）\n\n通过使用 Navigator 2.0，开发者可以更加精细地控制应用的导航行为。这包括对路由的动态添加、移除和替换，以及对路由访问的权限控制等。这样的灵活性使得 Flutter 应用能够更好地适应复杂的业务需求。\n\nNavigation 2.0 的设计理念是将路由状态与应用状态解耦，使得路由管理更加清晰和可控。\n\n通过合理使用 Navigation 2.0 的特性，开发者可以构建出结构清晰、易于维护的应用导航系统。这对于大型应用尤为重要。',

      'Flutter 主题系统支持应用的全局和局部主题定制。\n\n主题定制：\n1. 全局主题（MaterialApp.theme）\n2. 局部主题（Theme.of(context)）\n3. 动态主题切换\n\n通过使用 ThemeData，开发者可以轻松定义应用的色彩、字体和形状等视觉属性。这不仅可以提升应用的美观性，还能增强品牌识别度。同时，Flutter 还支持在运行时动态切换主题，极大地方便了开发者实现用户个性化定制的需求。\n\n主题系统不仅影响应用的外观，还关系到用户体验的一致性。通过合理设计和使用主题，可以提升应用的专业性和用户满意度。\n\n在实现主题切换功能时，开发者需要考虑状态管理和数据持久化等问题，以确保用户的选择能够被正确保存和应用。',

      'Flutter 桌面支持让开发者可以使用 Flutter 构建跨平台的桌面应用。\n\n桌面支持特性：\n1. 原生窗口和菜单\n2. 拖放文件支持\n3. 系统托盘图标\n\n通过使用 Flutter 的桌面支持，开发者可以用一套代码同时构建 Windows、macOS 和 Linux 平台的应用。这不仅提高了开发效率，还能确保应用在不同平台上的一致性和稳定性。\n\n桌面应用开发需要考虑与操作系统特性的集成，以及不同平台间的差异处理。\n\n为了提供更好的桌面用户体验，开发者需要关注应用的性能、界面设计和交互方式等方面，使其更符合桌面用户的使用习惯。',

      '在 Flutter 应用中使用 SQLite 可以实现高效的本地数据存储。\n\n使用步骤：\n1. 添加 sqflite 插件\n2. 打开数据库\n3. 执行 CRUD 操作\n\n通过使用 SQLite，开发者可以轻松实现应用数据的持久化存储。这对于需要离线支持的应用尤为重要。结合 Flutter 的异步编程模型，使用 SQLite 进行数据存储的操作可以做到高效而不阻塞主线程。\n\n数据库设计需要考虑数据结构的合理性、查询效率以及数据一致性等问题。\n\n在使用 SQLite 时，开发者还需要关注数据库的版本管理和迁移策略，以确保应用升级时数据的兼容性。',

      'Flutter 和 React Native 是当前最流行的两种跨平台移动应用开发框架。\n\n对比分析：\n1. 性能：Flutter 更接近原生，React Native 依赖于桥接\n2. 开发效率：Flutter 热重载更快，React Native 生态成熟\n3. 社区支持：React Native 社区更大，Flutter 发展迅速\n\n选择合适的框架需要根据项目需求、团队技术栈和长期维护成本等多方面考虑。在对性能要求极高的项目中，Flutter 可能是更好的选择；而在需要快速迭代和广泛社区支持的项目中，React Native 则具有优势。\n\n两种框架都有各自的优势和适用场景，开发者需要根据具体情况进行选择。\n\n随着技术的不断发展，两种框架都在持续改进和完善，为开发者提供更好的开发体验和更强大的功能支持。',
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
}