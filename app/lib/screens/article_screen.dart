import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:markdown/markdown.dart' as md;
import '../models/article.dart';
import '../services/article_service.dart';
import '../services/user_provider.dart';

class ArticleScreen extends StatefulWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool _isFavorited = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      // 用户未登录，无法检查收藏状态
      return;
    }
    
    final userId = userProvider.user!.id;
    
    try {
      final isFavorited = await ArticleService.isArticleFavorited(userId, widget.article.id);
      setState(() {
        _isFavorited = isFavorited;
      });
    } catch (e) {
      print('检查收藏状态失败: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;
    
    final userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      // 用户未登录，显示提示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先登录以使用收藏功能')),
      );
      return;
    }
    
    final userId = userProvider.user!.id;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isFavorited) {
        // 取消收藏
        await ArticleService.deleteFavorite(userId, 'article', widget.article.id);
        userProvider.removeFavoriteArticle(widget.article.id);
        setState(() {
          _isFavorited = false;
        });
      } else {
        // 添加收藏
        await ArticleService.createFavorite(userId, articleId: widget.article.id);
        userProvider.addFavoriteArticle(widget.article.id);
        setState(() {
          _isFavorited = true;
        });
      }
    } catch (e) {
      print('收藏操作失败: $e');
      // 可以在这里显示错误提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('收藏操作失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    // Article screen should always use the same layout regardless of screen size or orientation
    // It should not show navigation rail or bottom navigation
    return _buildArticleView();
  }

  Widget _buildArticleView() {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
        slivers: [
          SliverAppBar(
            expandedHeight: 200,  // 展开时的高度
            collapsedHeight: 60, // 折叠高度
            floating: false,       // 允许向下滚动时重新显示
            pinned: true,        // 完全隐藏
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: _buildFlexibleSpaceBar(),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
            ],
          ),
          // Article content without header title
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ArticleHeaderWithoutTitle(widget.article),
                  _ArticleSummary(aiSummary: widget.article.aiSummary),
                  _ArticleContent(widget.article),
                  // Add a divider similar to Zhihu's style
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      height: 32.0, // Increase height for better visual separation
                      thickness: 0.5, // Thin line
                      color: Colors.grey, // Color similar to Zhihu
                    ),
                  ),
                  // Add 1/4 screen height padding at the end of the article
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final screenHeight = MediaQuery.of(context).size.height;
                      return SizedBox(height: screenHeight * 0.25);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFavorite,
        backgroundColor: _isFavorited ? Colors.red : null,
        child: _isLoading 
          ? const CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
          : Icon(_isFavorited ? Icons.favorite : Icons.favorite_border, 
                 color: _isFavorited ? Colors.white : null),
      ),
    );
  }

  Widget _buildFlexibleSpaceBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 获取安全区域边距
        final EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
        
        // 计算展开比例
        final double expandRatio = (constraints.biggest.height - 60) / (200 - 60);
        // 确保比例在 0-1 之间
        final double clampedRatio = expandRatio.clamp(0.0, 1.0);
        
        // 动态计算左边距：展开时为 16 + 安全区域左边距，收缩时为 72 + 安全区域左边距
        final double leftPadding = 16 + (72 - 16) * (1 - clampedRatio) + safeAreaPadding.left;
        
        // 动态计算右边距：展开时为 16 + 安全区域右边距，收缩时为 72 + 安全区域右边距（为分享按钮留出空间）
        final double rightPadding = 16 + (72 - 16) * (1 - clampedRatio) + safeAreaPadding.right;
        
        // 动态设置最大行数：展开时3行，收缩时1行
        final int maxLines = clampedRatio < 0.5 ? 1 : 3;
        
        return FlexibleSpaceBar(
          expandedTitleScale: 1.5,
          title: Text(
            widget.article.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontVariations: [FontVariation('wght', 700.0)], // 保持粗体效果
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          titlePadding: EdgeInsets.only(
            left: leftPadding,
            bottom: 17,
            right: rightPadding,
          ),
        );
      },
    );
  }
}

class _ArticleHeader extends StatelessWidget {
  final Article article;

  const _ArticleHeader(this.article);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontVariations: [FontVariation('wght', 700.0)], // 保持粗体效果
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '日期: ${article.createdAt.year}-${article.createdAt.month}-${article.createdAt.day}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontVariations: [FontVariation('wght', 500.0)],
            ),
          ),
          Text(
            '作者: John Doe', // TODO: Replace with actual author name
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontVariations: [FontVariation('wght', 500.0)],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: null, // TODO: Implement follow functionality
            child: const Text('关注作者'),
          ),
        ],
      ),
    );
  }
}

class _ArticleHeaderWithoutTitle extends StatelessWidget {
  final Article article;

  const _ArticleHeaderWithoutTitle(this.article);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '日期: ${article.createdAt.year}-${article.createdAt.month}-${article.createdAt.day}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontVariations: [FontVariation('wght', 500.0)],
            ),
          ),
          Text(
            '作者: John Doe', // TODO: Replace with actual author name
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontVariations: [FontVariation('wght', 500.0)],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: null, // TODO: Implement follow functionality
            child: const Text('关注作者'),
          ),
        ],
      ),
    );
  }
}

class _ArticleSummary extends StatelessWidget {
  final String? aiSummary;

  const _ArticleSummary({this.aiSummary});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // 如果没有AI摘要，则不显示摘要部分
    if (aiSummary == null || aiSummary!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        // 移除阴影效果
        elevation: 0,
        // 使用surfaceContainer颜色来创建与背景的更好区分（在所有平台上都有更好的可见性）
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI 摘要',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontVariations: [FontVariation('wght', 700.0)], // 保持粗体效果
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      aiSummary!,
                      style: textTheme.titleMedium?.copyWith(
                        fontVariations: [FontVariation('wght', 500.0)], // 使用与主题一致的字重
                      ),
                      textAlign: TextAlign.left, // 修改为左对齐
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  final Article article;

  const _ArticleContent(this.article);

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: article.content,
      styleSheet: MarkdownStyleSheet(
        h1: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontVariations: [FontVariation('wght', 700.0)],
        ),
        h2: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontVariations: [FontVariation('wght', 600.0)],
        ),
        h3: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontVariations: [FontVariation('wght', 500.0)],
        ),
        h4: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontVariations: [FontVariation('wght', 500.0)],
        ),
        p: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontVariations: [FontVariation('wght', 500.0)],
        ),
        em: const TextStyle(fontStyle: FontStyle.italic),
        strong: const TextStyle(fontWeight: FontWeight.bold),
        code: const TextStyle(
          fontFamily: 'monospace',
          backgroundColor: Colors.grey,
          color: Colors.white,
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        blockquote: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade700,
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 4.0,
            ),
          ),
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(4.0),
            right: Radius.circular(8.0),
          ),
        ),
        listBullet: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontVariations: [FontVariation('wght', 500.0)],
        ),
        tableHead: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontVariations: [FontVariation('wght', 700.0)],
        ),
        tableBody: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontVariations: [FontVariation('wght', 500.0)],
        ),
        tableBorder: TableBorder.all(
          color: Colors.grey.shade300,
        ),
        tableCellsDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      onTapLink: (text, href, title) {
        // 处理链接点击事件
        // TODO: 实现链接跳转功能
        print('Link tapped: $href');
      },
      selectable: true,
      // Use GitHub Flavored Markdown for better feature support
      extensionSet: md.ExtensionSet.gitHubFlavored,
      // Add properties to fix scroll conflict in CustomScrollView
      physics: const NeverScrollableScrollPhysics(), // Disable scroll physics to prevent conflict
      shrinkWrap: true, // Make the widget size to its content
    );
  }
}