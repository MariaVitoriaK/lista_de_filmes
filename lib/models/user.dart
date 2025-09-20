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
    this.avatarUrl =
        "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
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
    avatarUrl:
        json['avatarUrl'] ??
        "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png",
  );

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
