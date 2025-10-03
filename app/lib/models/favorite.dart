class Favorite {
  final int userId;
  final int? articleId;
  final int? magazineId;
  final DateTime createdAt;

  Favorite({
    required this.userId,
    this.articleId,
    this.magazineId,
    required this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userId: json['user_id'],
      articleId: json['article_id'],
      magazineId: json['magazine_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'article_id': articleId,
      'magazine_id': magazineId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}