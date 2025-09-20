import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';
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

    Widget buildMovieCard(Movie movie) {
      return Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Poster
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: movie.posterUrl.isNotEmpty
                    ? Image.network(
                        movie.posterUrl,
                        width: 140,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, error, stackTrace) => Container(
                          width: 140,
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, size: 50),
                        ),
                      )
                    : Container(
                        width: 140,
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(Icons.movie, size: 50),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Favorito
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                            iconSize: 20,
                            icon: Icon(
                              movie.isFavorite ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                            onPressed: () =>
                                movieProvider.toggleFavorite(movie.id),
                            tooltip: 'Favorito',
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Quero assistir
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                            iconSize: 20,
                            icon: Icon(
                              movie.isWantToWatch
                                  ? Icons.visibility
                                  : Icons.visibility_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () =>
                                movieProvider.toggleWantToWatch(movie.id),
                            tooltip: 'Quero assistir',
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Info
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                            iconSize: 20,
                            icon: const Icon(Icons.info, color: Colors.purple),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title: Text(movie.title),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (movie.posterUrl.isNotEmpty)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              movie.posterUrl,
                                              height: 200,
                                              fit: BoxFit.cover,
                                              errorBuilder: (c, e, s) =>
                                                  Container(
                                                    height: 200,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.movie,
                                                      size: 50,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${movie.year} • ${movie.director}",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          movie.genres,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          movie.description,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("Fechar"),
                                      onPressed: () => Navigator.of(ctx).pop(),
                                    ),
                                  ],
                                ),
                              );
                            },
                            tooltip: 'Mais informações',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Minha Área")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "⭐ Favoritos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            favMovies.isEmpty
                ? const Text("Nenhum filme favorito ainda.")
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: favMovies
                          .map((m) => buildMovieCard(m))
                          .toList(),
                    ),
                  ),
            const SizedBox(height: 20),
            const Text(
              "👁️ Quero Assistir",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            wantMovies.isEmpty
                ? const Text("Nenhum filme na lista Quero Ver ainda.")
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: wantMovies
                          .map((m) => buildMovieCard(m))
                          .toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
