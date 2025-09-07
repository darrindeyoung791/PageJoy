import 'package:flutter/material.dart';
import '../models/article.dart';

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
      appBar: AppBar(
        title: const Text('文章'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ArticleHeader(widget.article),
              const _ArticleSummary(),
              _ArticleContent(widget.article),
            ],
          ),
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
  final Article article;

  const _ArticleHeader(this.article);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('日期: ${article.createdAt.year}-${article.createdAt.month}-${article.createdAt.day}'),
          const Text('作者: John Doe'), // TODO: Replace with actual author name
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
  const _ArticleSummary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI 摘要',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '这是文章内容的摘要，下列内容用于将其变长。\n好笑吗，我只看到我的手机经过了HLS 协议，一种基于 HTTP 的流媒体传输协议，广泛应用于视频点播和直播。它通过将视频内容切割成多个小片段（通常是 TS 格式或 fMP4 格式），并生成一个 M3U8 播放列表文件。客户端通过 HTTP 请求下载播放列表文件，然后按顺序下载和播放这些片段，然后又经过RTSP（Real-Time Streaming Protocol）：用于控制流媒体传输的协议，实现播放、暂停、快进等功能。 ',
                style: TextStyle(fontSize: 20),
              ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        article.content,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}