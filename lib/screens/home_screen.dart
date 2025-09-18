// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _addMovie(BuildContext context) {
    final titleController = TextEditingController();
    final dirController = TextEditingController();
    final genreController = TextEditingController();
    final descController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Adicionar Filme"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: "Ano"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final newMovie = Movie(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: titleController.text,
                director: dirController.text,
                genres: genreController.text,
                description: descController.text,
                year: yearController.text,
              );
              Provider.of<MovieProvider>(
                context,
                listen: false,
              ).addMovie(newMovie);
              Navigator.pop(ctx);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("MovieLists")),
      drawer: const AppDrawer(), // << aqui entra o menu

      body: ListView.builder(
        itemCount: movieProvider.movies.length,
        itemBuilder: (ctx, i) {
          final movie = movieProvider.movies[i];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text("${movie.year} - ${movie.description}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => movieProvider.deleteMovie(movie.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addMovie(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
