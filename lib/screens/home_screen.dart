// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _addMovie(BuildContext context) {
    final titleController = TextEditingController();
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
                description: descController.text,
                year: int.tryParse(yearController.text) ?? 0,
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
      appBar: AppBar(
        title: const Text("Meus Filmes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => Navigator.pushNamed(context, '/map'),
          ),
        ],
      ),
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
