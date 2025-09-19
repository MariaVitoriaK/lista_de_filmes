class Movie {
  final String id;
  String title;
  String director;
  String genres; // vou deixar como string tratada
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
    id: json['id'].toString(),
    title: json['title'] ?? '',
    director: json['director'] ?? '',
    genres: json['genres'] is List
        ? (json['genres'] as List).join(', ')
        : (json['genres'] ?? ''),
    description: json['description'] ?? '',
    year: json['year']?.toString() ?? '',
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
