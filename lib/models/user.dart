// lib/models/user.dart
class User {
  final String? id; // null se ainda não foi criado
  String name;
  String email;
  String password; // texto simples para estudo
  String avatar;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
  });

  // Converte de Map/JSON para objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  // Converte objeto User em Map/JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }
}
