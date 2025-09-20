import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  final String baseUrl =
      'https://68c5a3e7a712aaca2b6949cd.mockapi.io/api/v1/movies';

  /// Carrega todos os filmes do MockAPI
  Future<void> loadMovies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        _movies = list.map((e) => Movie.fromJson(e)).toList();
        notifyListeners();
      } else {
        debugPrint('Erro ao carregar filmes: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao carregar filmes: $e');
    }
  }

  /// Adiciona um filme
  Future<void> addMovie(Movie movie) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(movie.toJson()),
      );

      if (response.statusCode == 201) {
        final newMovie = Movie.fromJson(jsonDecode(response.body));
        _movies.add(newMovie);
        notifyListeners();
      } else {
        debugPrint('Erro ao adicionar filme: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao adicionar filme: $e');
    }
  }

  /// Atualiza um filme
  Future<void> updateMovie(Movie movie) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${movie.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(movie.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _movies.indexWhere((m) => m.id == movie.id);
        if (index != -1) {
          _movies[index] = movie;
          notifyListeners();
        }
      } else {
        debugPrint('Erro ao atualizar filme: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao atualizar filme: $e');
    }
  }

  /// Remove um filme
  Future<void> deleteMovie(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        _movies.removeWhere((m) => m.id == id);
        notifyListeners();
      } else {
        debugPrint('Erro ao deletar filme: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao deletar filme: $e');
    }
  }

  /// favorito
  Future<void> toggleFavorite(String id) async {
    final index = _movies.indexWhere((m) => m.id == id);
    if (index != -1) {
      _movies[index].isFavorite = !_movies[index].isFavorite;
      notifyListeners();
      await updateMovie(_movies[index]);
    }
  }

  /// Quero Assistir
  Future<void> toggleWantToWatch(String id) async {
    final index = _movies.indexWhere((m) => m.id == id);
    if (index != -1) {
      _movies[index].isWantToWatch = !_movies[index].isWantToWatch;
      notifyListeners();
      await updateMovie(_movies[index]);
    }
  }
}
