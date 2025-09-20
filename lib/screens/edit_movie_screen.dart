import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class EditMovieScreen extends StatelessWidget {
  final Movie movie;
  const EditMovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController(text: movie.title);
    final _dirController = TextEditingController(text: movie.director);
    final _genreController = TextEditingController(text: movie.genres);
    final _descController = TextEditingController(text: movie.description);
    final _yearController = TextEditingController(text: movie.year);
    final _posterController = TextEditingController(text: movie.posterUrl);

    void _save() {
      movie.title = _titleController.text;
      movie.director = _dirController.text;
      movie.genres = _genreController.text;
      movie.description = _descController.text;
      movie.year = _yearController.text;
      movie.posterUrl = _posterController.text;

      Provider.of<MovieProvider>(context, listen: false).updateMovie(movie);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Filme")),
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
            ElevatedButton(onPressed: _save, child: const Text("Salvar")),
          ],
        ),
      ),
    );
  }
}
