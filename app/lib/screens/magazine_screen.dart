import 'package:flutter/material.dart';

class MagazineScreen extends StatelessWidget {
  const MagazineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MagazineHeader(),
            const _MagazineArticles(),
          ],
        ),
      ),
    );
  }
}

class _MagazineHeader extends StatelessWidget {
  const _MagazineHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://via.placeholder.com/400x200'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Magazine Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Magazine Description',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MagazineArticles extends StatelessWidget {
  const _MagazineArticles();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Articles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // TODO: Implement articles list
          Text('List of articles in this magazine'),
        ],
      ),
    );
  }
}