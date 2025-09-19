// lib/screens/add_movie_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class AddMovieScreen extends StatelessWidget {
  AddMovieScreen({super.key});

  final _titleController = TextEditingController();
  final _dirController = TextEditingController();
  final _genreController = TextEditingController();
  final _descController = TextEditingController();
  final _yearController = TextEditingController();
  final _posterController = TextEditingController();

  void _save(BuildContext context) {
    final newMovie = Movie(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      director: _dirController.text,
      genres: _genreController.text,
      description: _descController.text,
      year: _yearController.text,
      posterUrl: _posterController.text,
    );
    Provider.of<MovieProvider>(context, listen: false).addMovie(newMovie);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Filme")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _dirController,
              decoration: const InputDecoration(labelText: "Diretor"),
            ),
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(labelText: "Gêneros"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: "Ano"),
            ),
            TextField(
              controller: _posterController,
              decoration: const InputDecoration(labelText: "URL do Poster"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _save(context),
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
