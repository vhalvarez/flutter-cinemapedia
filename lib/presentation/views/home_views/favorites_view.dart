import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;

    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            const SizedBox(height: 20),
            const Text('No hay peliculas favoritas'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Buscar peliculas'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: favoriteMovies),
    );
  }
}
