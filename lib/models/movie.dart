// lib/models/movie.dart
class Movie {
  String id;
  String title;
  String description;
  int year;
  bool isFavorite;
  bool isWantToWatch;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    this.isFavorite = false,
    this.isWantToWatch = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    year: json['year'],
    isFavorite: json['isFavorite'] ?? false,
    isWantToWatch: json['isWantToWatch'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'year': year,
    'isFavorite': isFavorite,
    'isWantToWatch': isWantToWatch,
  };
}
