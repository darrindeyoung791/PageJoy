import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import '../widgets/article_card.dart';
import '../widgets/article_skeleton.dart'; // Import skeleton loader
import '../widgets/profile_content.dart'; // Import ProfileContent

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isOffline = true;

  void _toggleOfflineMode() {
    setState(() {
      _isOffline = !_isOffline;
      ArticleService.setOfflineMode(_isOffline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth > 600;
        final bool isLandscape = constraints.maxWidth > constraints.maxHeight;
        
        // For wide screens (tablets, desktops) in landscape mode, use NavigationRail
        if (isWideScreen && isLandscape) {
          return _buildNavigationRail();
        } 
        // For mobile screens or portrait mode, use BottomNavigationBar
        else {
          return _buildBottomNavigation();
        }
      },
    );
  }

  Widget _buildNavigationRail() {
    return Scaffold(
      body: Row(
        children: [
          // Navigation rail without PageJoy title
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer, // 直接设置背景色
            elevation: 1, // 添加阴影效果
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('首页'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('收藏'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('我的'),
              ),
            ],
          ),
          // Main content
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
              slivers: [
                SliverAppBar(
                  expandedHeight: 120,
                  collapsedHeight: 60,
                  floating: false,
                  pinned: true,
                  flexibleSpace: _buildFlexibleSpaceBar(),
                  actions: [
                    IconButton(
                      icon: Icon(_isOffline ? Icons.wifi_off : Icons.wifi),
                      onPressed: _toggleOfflineMode,
                      tooltip: _isOffline ? '离线模式' : '在线模式',
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // TODO: Implement search functionality
                      },
                    ),
                  ],
                ),
                // 将主体内容转换为 Sliver
                SliverToBoxAdapter(
                  child: _buildBody(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
        slivers: [
          SliverAppBar(
            expandedHeight: 200,  // 展开时的高度
            collapsedHeight: 60, // 折叠高度
            floating: false,       // 允许向下滚动时重新显示
            pinned: true,        // 完全隐藏
            flexibleSpace: _buildFlexibleSpaceBar(),
            actions: [
              IconButton(
                icon: Icon(_isOffline ? Icons.wifi_off : Icons.wifi),
                onPressed: _toggleOfflineMode,
                tooltip: _isOffline ? '离线模式' : '在线模式',
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Implement search functionality
                },
              ),
            ],
          ),
          // 将主体内容转换为 Sliver
          SliverToBoxAdapter(
            child: _buildBody(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: '收藏',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _HomeFeed(isOffline: _isOffline);
      case 1:
        return const _FavoritesScreen();
      case 2:
        return const _ProfileScreen();
      default:
        return _HomeFeed(isOffline: _isOffline);
    }
  }

  Widget _buildFlexibleSpaceBar() {
    return Builder(
      builder: (BuildContext context) {
        // 获取安全区域边距
        final EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
        
        return FlexibleSpaceBar(
          expandedTitleScale: 2,
          title: const Text('PageJoy'), // 恢复标题显示
          titlePadding: EdgeInsets.only(
            left: 16 + safeAreaPadding.left,
            bottom: 16,
            right: 16 + safeAreaPadding.right,
          ),
        );
      },
    );
  }
}

class _HomeFeed extends StatelessWidget {
  final bool isOffline;

  const _HomeFeed({this.isOffline = false});

  @override
  Widget build(BuildContext context) {
    return ArticleFeed(isOffline: isOffline);
  }
}

class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('收藏'),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return const ProfileContent();
  }
}

class ArticleFeed extends StatefulWidget {
  final bool isOffline;

  const ArticleFeed({super.key, this.isOffline = false});

  @override
  State<ArticleFeed> createState() => _ArticleFeedState();
}

class _ArticleFeedState extends State<ArticleFeed> {
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ArticleService.getArticles();
  }

  @override
  void didUpdateWidget(covariant ArticleFeed oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If offline mode changes, reload articles
    if (oldWidget.isOffline != widget.isOffline) {
      setState(() {
        _articlesFuture = ArticleService.getArticles();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _articlesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Use skeleton loader instead of circular progress indicator
          return const ArticleSkeletonList();
        } else if (snapshot.hasError) {
          return _buildErrorContent();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('未找到文章'));
        } else {
          final articles = snapshot.data!;
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show offline indicator if in offline mode
                if (widget.isOffline)
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.wifi_off, color: Colors.orange),
                        const SizedBox(width: 8),
                        Builder(
                          builder: (context) {
                            return Text(
                              '离线模式 - 显示示例内容',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontVariations: [FontVariation('wght', 500.0)],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                // Headline carousel (first 3 articles)
                if (articles.length >= 3)
                  HeadlineCarousel(articles: articles.take(3).toList()),
                ArticleList(
                  articles: articles.length > 3 ? articles.sublist(3) : [],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildErrorContent() {
    // If we're in offline mode, show sample content
    if (widget.isOffline) {
      // Load sample articles directly
      final sampleArticles = ArticleService.generateSampleArticles();
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offline indicator
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange),
              ),
              child: Row(
                children: [
                  const Icon(Icons.wifi_off, color: Colors.orange),
                  const SizedBox(width: 8),
                  Builder(
                          builder: (context) {
                            return Text(
                              '离线模式 - 显示示例内容',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                                fontVariations: [FontVariation('wght', 500.0)],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
            // Headline carousel (first 3 articles)
            if (sampleArticles.length >= 3)
              HeadlineCarousel(articles: sampleArticles.take(3).toList()),
            // Article list (remaining articles)
            ArticleList(articles: sampleArticles.length > 3 ? sampleArticles.sublist(3) : []),
          ],
        ),
      );
    }
    
    // For other errors, show error message
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Builder(
            builder: (context) {
              return Text(
                '加载文章失败',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              );
            }
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (context) {
              return Text(
                '请检查您的网络连接',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _articlesFuture = ArticleService.getArticles();
              });
            },
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }
}

class ArticleSkeletonList extends StatelessWidget {
  const ArticleSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => const ArticleSkeleton(),
      ),
    );
  }
}

class HeadlineCarousel extends StatefulWidget {
  final List<Article> articles;

  const HeadlineCarousel({super.key, required this.articles});

  @override
  State<HeadlineCarousel> createState() => _HeadlineCarouselState();
}

class _HeadlineCarouselState extends State<HeadlineCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.articles.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final article = widget.articles[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to article screen when carousel item is tapped
                  Navigator.pushNamed(
                    context,
                    '/article',
                    arguments: article,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/img/example1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Builder(
                                builder: (context) {
                                  return Text(
                                    article.title,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                              ),
                              const SizedBox(height: 8),
                              Builder(
                                builder: (context) {
                                  return Text(
                                    '创作者 • ${article.createdAt.day}/${article.createdAt.month}/${article.createdAt.year}',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontVariations: [FontVariation('wght', 500.0)],
                                    ),
                                  );
                                }
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Page indicator
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.articles.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleList extends StatelessWidget {
  final List<Article> articles;

  const ArticleList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
        
        return Column(
          children: List.generate(
            (articles.length / crossAxisCount).ceil(),
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ArticleCard(
                      article: articles[index * crossAxisCount],
                    ),
                  ),
                  if (crossAxisCount == 2 &&
                      index * 2 + 1 < articles.length) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: ArticleCard(
                        article: articles[index * crossAxisCount + 1],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

