// lib/providers/movie_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  /// 🔹 Carregar filmes do SharedPreferences
  Future<void> loadMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final moviesJson = prefs.getString('movies');
    if (moviesJson != null) {
      final List list = jsonDecode(moviesJson);
      _movies = list.map((e) => Movie.fromJson(e)).toList();
      notifyListeners();
    }
  }

  /// 🔹 Adicionar novo filme
  Future<void> addMovie(Movie movie) async {
    _movies.add(movie);
    await _save();
    notifyListeners();
  }

  /// 🔹 Atualizar um filme existente
  Future<void> updateMovie(Movie movie) async {
    final index = _movies.indexWhere((m) => m.id == movie.id);
    if (index != -1) {
      _movies[index] = movie;
      await _save();
      notifyListeners();
    }
  }

  /// 🔹 Remover filme pelo id
  Future<void> deleteMovie(String id) async {
    _movies.removeWhere((m) => m.id == id);
    await _save();
    notifyListeners();
  }

  /// 🔹 Salvar lista de filmes no SharedPreferences
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _movies.map((m) => m.toJson()).toList();
    await prefs.setString('movies', jsonEncode(list));
  }
}
