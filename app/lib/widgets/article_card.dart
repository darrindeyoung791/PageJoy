import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/article',
            arguments: article,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 124,
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
                      Text(
                        article.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Creator chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '创作者',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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
    );
  }
}