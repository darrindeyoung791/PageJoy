class Article {
  final int id;
  final String title;
  final String content;
  final String status;
  final bool isPremium;
  final double? price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewCount;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.isPremium,
    this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.viewCount,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
      isPremium: json['is_premium'],
      price: json['price']?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      viewCount: json['view_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'status': status,
      'is_premium': isPremium,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'view_count': viewCount,
    };
  }
}