import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                // const CustomAppbar(),
                MoviesSlideshow(movies: moviesSlideshow),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: "En Cines",
                  subTitle: "Lunes 20",
                  loadNextPage:
                      () => {
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage(),
                      },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: "Proximamente",
                  subTitle: "En este mes",
                  loadNextPage:
                      () => {
                        ref
                            .read(upcomingMoviesProvider.notifier)
                            .loadNextPage(),
                      },
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: "Populares",
                  loadNextPage:
                      () => {
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                      },
                ),

                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: "Mejores Calificadas",
                  loadNextPage:
                      () => {
                        ref
                            .read(topRatedMoviesProvider.notifier)
                            .loadNextPage(),
                      },
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
