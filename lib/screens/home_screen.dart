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
    final posterController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Adicionar Filme"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: dirController,
                decoration: const InputDecoration(labelText: "Diretor"),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: "Gêneros"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(labelText: "Ano"),
              ),
              TextField(
                controller: posterController,
                decoration: const InputDecoration(labelText: "URL do Poster"),
              ),
            ],
          ),
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
                posterUrl: posterController.text,
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
      drawer: const AppDrawer(),

      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: movieProvider.movies.length,
        itemBuilder: (ctx, i) {
          final movie = movieProvider.movies[i];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster maior
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: movie.posterUrl.isNotEmpty
                      ? Image.network(
                          movie.posterUrl,
                          width: 120,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, error, stack) => Container(
                            width: 120,
                            height: 180,
                            color: Colors.grey[300],
                            child: const Icon(Icons.movie, size: 50),
                          ),
                        )
                      : Container(
                          width: 120,
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, size: 50),
                        ),
                ),

                // Informações do filme
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${movie.year} • ${movie.director}",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          movie.genres,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        // Ícones de ações: favorito, quero assistir, editar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                movie.isFavorite
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () =>
                                  movieProvider.toggleFavorite(movie.id),
                            ),
                            IconButton(
                              icon: Icon(
                                movie.isWantToWatch
                                    ? Icons.visibility
                                    : Icons.visibility_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: () =>
                                  movieProvider.toggleWantToWatch(movie.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.green),
                              onPressed: () {
                                // Editar filme
                                final titleController = TextEditingController(
                                  text: movie.title,
                                );
                                final dirController = TextEditingController(
                                  text: movie.director,
                                );
                                final genreController = TextEditingController(
                                  text: movie.genres,
                                );
                                final descController = TextEditingController(
                                  text: movie.description,
                                );
                                final yearController = TextEditingController(
                                  text: movie.year,
                                );
                                final posterController = TextEditingController(
                                  text: movie.posterUrl,
                                );

                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Editar Filme"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              labelText: "Título",
                                            ),
                                          ),
                                          TextField(
                                            controller: dirController,
                                            decoration: const InputDecoration(
                                              labelText: "Diretor",
                                            ),
                                          ),
                                          TextField(
                                            controller: genreController,
                                            decoration: const InputDecoration(
                                              labelText: "Gêneros",
                                            ),
                                          ),
                                          TextField(
                                            controller: descController,
                                            decoration: const InputDecoration(
                                              labelText: "Descrição",
                                            ),
                                          ),
                                          TextField(
                                            controller: yearController,
                                            decoration: const InputDecoration(
                                              labelText: "Ano",
                                            ),
                                          ),
                                          TextField(
                                            controller: posterController,
                                            decoration: const InputDecoration(
                                              labelText: "URL do Poster",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text("Cancelar"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          movie.title = titleController.text;
                                          movie.director = dirController.text;
                                          movie.genres = genreController.text;
                                          movie.description =
                                              descController.text;
                                          movie.year = yearController.text;
                                          movie.posterUrl =
                                              posterController.text;

                                          movieProvider.updateMovie(movie);
                                          Navigator.pop(ctx);
                                        },
                                        child: const Text("Salvar"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Botão excluir
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => movieProvider.deleteMovie(movie.id),
                ),
              ],
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
