import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import '../services/user_provider.dart';

class ArticleCard extends StatefulWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isFavorited = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 初始化时检查收藏状态
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) {
      final userId = userProvider.user!.id;
      // 在实际应用中，这里可能需要异步检查收藏状态
      // 这里我们使用UserProvider中的状态
      setState(() {
        _isFavorited = userProvider.isArticleFavorited(widget.article.id);
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;
    
    final userProvider = context.read<UserProvider>();
    if (userProvider.user == null) {
      // 用户未登录，可以显示提示或引导登录
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
      } else {
        // 添加收藏
        await ArticleService.createFavorite(userId, articleId: widget.article.id);
        userProvider.addFavoriteArticle(widget.article.id);
      }
      setState(() {
        _isFavorited = !_isFavorited;
      });
    } catch (e) {
      print('收藏操作失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('收藏操作失败: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final isCurrentUserFavorited = userProvider.isArticleFavorited(widget.article.id);
    
    // 确保UI与provider状态同步
    if (_isFavorited != isCurrentUserFavorited) {
      _isFavorited = isCurrentUserFavorited;
    }

    return Card(
      // 移除阴影效果
      elevation: 0,
      // 使用surfaceContainer颜色来创建与背景的更好区分（在所有平台上都有更好的可见性）
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/article',
            arguments: widget.article,
          );
        },
        borderRadius: BorderRadius.circular(12),
        // 添加轻微的边框以在某些情况下增强可读性
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
          child: SizedBox(
            height: 96,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/img/example1.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Content
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with larger font size
                            Builder(
                              builder: (context) {
                                return Text(
                                  widget.article.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: 1.3,
                                  ),
                                );
                              }
                            ),
                            const SizedBox(height: 8),
                            // Creator chip
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Builder(
                                builder: (context) {
                                  return Text(
                                    '创作者',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontVariations: [FontVariation('wght', 500.0)],
                                    ),
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // 收藏按钮 - 放在右上角
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: _isLoading 
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            isCurrentUserFavorited ? Icons.favorite : Icons.favorite_border,
                            color: isCurrentUserFavorited ? Colors.red : Colors.grey,
                            size: 24,
                          ),
                      onPressed: _toggleFavorite,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}