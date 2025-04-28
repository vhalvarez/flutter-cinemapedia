import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
                title: CustomAppbar(),
            ),
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
                  movies: nowPlayingMovies,
                  title: "Proximamente",
                  subTitle: "En este mes",
                  loadNextPage:
                      () => {
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage(),
                      },
                ),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: "Populares",
                  loadNextPage:
                      () => {
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage(),
                      },
                ),

                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: "Mejores Calificadas",
                  loadNextPage:
                      () => {
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
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
