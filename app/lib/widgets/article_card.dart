import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleCard extends StatefulWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {

  @override
  Widget build(BuildContext context) {
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
              child: Row(
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
            ),
          ),
        ),
      ),
    );
  }
}