import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation
import '../models/article.dart';

class ArticleScreen extends StatefulWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
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
        onPressed: () {
          // TODO: Implement like functionality
        },
        child: const Icon(Icons.favorite_border),
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
        // 使用surfaceContainerLow颜色来创建与背景的轻微区分
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.1),
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
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        article.content,
        style: textTheme.titleMedium?.copyWith(
          fontVariations: [FontVariation('wght', 500.0)], // 使用与主题一致的字重
        ),
      ),
    );
  }
}