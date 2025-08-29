import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ArticleHeader(),
            const _ArticleSummary(),
            const _ArticleContent(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement like functionality
        },
        child: const Icon(Icons.favorite_border),
      ),
    );
  }
}

class _ArticleHeader extends StatelessWidget {
  const _ArticleHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Article Title',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Date: 2023-01-01'),
          Text('Author: John Doe'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: null, // TODO: Implement follow functionality
            child: Text('Follow Author'),
          ),
        ],
      ),
    );
  }
}

class _ArticleSummary extends StatelessWidget {
  const _ArticleSummary();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'This is a summary of the article content. It provides a brief overview of the main points discussed in the article.',
          ),
        ],
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  const _ArticleContent();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'This is the full content of the article. It contains all the details and information that the author wants to share with the readers. '
        'The content can be quite long and may include multiple paragraphs, images, and other media elements to enhance the reading experience. '
        'In a real application, this would be dynamically loaded from the backend API based on the article ID.',
      ),
    );
  }
}