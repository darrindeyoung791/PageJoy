class User {
  final int id;
  final String username;
  final String? email;
  final String? phone;
  final String? wechatId;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    this.email,
    this.phone,
    this.wechatId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      wechatId: json['wechat_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'wechat_id': wechatId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}