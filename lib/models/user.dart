class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.avatarUrl = "https://via.placeholder.com/150",
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'avatarUrl': avatarUrl,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    avatarUrl: json['avatarUrl'] ?? "https://via.placeholder.com/150",
  );

  // Aqui entra o copyWith
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
