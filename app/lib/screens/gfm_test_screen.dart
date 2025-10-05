import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import '../models/article.dart';

class GfmTestScreen extends StatefulWidget {
  const GfmTestScreen({super.key});

  @override
  State<GfmTestScreen> createState() => _GfmTestScreenState();
}

class _GfmTestScreenState extends State<GfmTestScreen> {
  String _markdownContent = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMarkdownContent();
  }

  Future<void> _loadMarkdownContent() async {
    try {
      final content = await rootBundle.loadString('assets/test_content/gfm_test_content.md');
      setState(() {
        _markdownContent = content;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _markdownContent = '# Error loading test content\n\nFailed to load GFM test content: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GFM Test Content'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildArticleContent(),
    );
  }

  Widget _buildArticleContent() {
    // Simulate an article with the test content
    final testArticle = Article(
      id: 999,
      title: 'GFM Test Article',
      content: _markdownContent,
      aiSummary: 'This is a test article containing various GFM (GitHub Flavored Markdown) elements to verify proper rendering in the PageJoy app.',
      status: 'published',
      isPremium: false,
      price: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      viewCount: 0,
    );

    return _ArticleContent(testArticle);
  }
}

class _ArticleContent extends StatelessWidget {
  final Article article;

  const _ArticleContent(this.article);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Markdown(
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
          onTapLink: (text, href, title) {
            // 处理链接点击事件
            // TODO: 实现链接跳转功能
            print('Link tapped: $href');
          },
          selectable: true,
          // Use GitHub Flavored Markdown for better feature support
          extensionSet: md.ExtensionSet.gitHubFlavored,
        ),
      ),
    );
  }
}