import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/app_drawer.dart';

class MyAreaScreen extends StatelessWidget {
  const MyAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final favMovies = movieProvider.movies.where((m) => m.isFavorite).toList();
    final wantMovies = movieProvider.movies
        .where((m) => m.isWantToWatch)
        .toList();

    Widget buildMovieCard(movie) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: movie.posterUrl.isNotEmpty
                  ? Image.network(
                      movie.posterUrl,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stackTrace) => Container(
                        width: 80,
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.movie, size: 40),
                      ),
                    )
                  : Container(
                      width: 80,
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(Icons.movie, size: 40),
                    ),
            ),

            // Info do filme
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${movie.year} • ${movie.director}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                    ),
                    Text(
                      movie.genres,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            movie.isFavorite ? Icons.star : Icons.star_border,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Minha Área")),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "⭐ Favoritos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            favMovies.isEmpty
                ? const Text("Nenhum filme favorito ainda.")
                : Column(children: favMovies.map(buildMovieCard).toList()),
            const SizedBox(height: 20),
            const Text(
              "👁️ Quero Assistir",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            wantMovies.isEmpty
                ? const Text("Nenhum filme na lista Quero Ver ainda.")
                : Column(children: wantMovies.map(buildMovieCard).toList()),
          ],
        ),
      ),
    );
  }
}
