// lib/models/movie.dart
class Movie {
  final String id;
  String title;
  String director;
  String genres;
  String description;
  String year;
  bool isFavorite;
  bool isWantToWatch;
  String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.genres,
    required this.description,
    required this.year,
    this.isFavorite = false,
    this.isWantToWatch = false,
    this.posterUrl = "",
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    director: json['director'],
    genres: json['genres'],
    year: json['year'],
    isFavorite: json['isFavorite'] ?? false,
    isWantToWatch: json['isWantToWatch'] ?? false,
    posterUrl: json['posterUrl'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'director': director,
    'genres': genres,
    'description': description,
    'year': year,
    'isFavorite': isFavorite,
    'isWantToWatch': isWantToWatch,
    'posterUrl': posterUrl,
  };
}
