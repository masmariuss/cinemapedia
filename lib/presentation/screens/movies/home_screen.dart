import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtonNavigation(),
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

    ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    // if (nowPlayingMovies.length == 0 )return CircularProgressIndicator();

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
          
        ),

        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {

          return Column(
            children: [
        
              // const CustomAppbar(),
              
              MoviesSlideShow(movies: slideShowMovies),
              
              /* Expanded(
                child: ListView.builder(
                    itemCount: nowPlayingMovies.length,
                    itemBuilder: (context, index) {
                      final movie = nowPlayingMovies[index];
                      return ListTile(
                        title: Text(movie.title),
                      );
                    }),
              ) */
        
              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Lunes 20',
                loadNextPage: () {
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
                }
              ),

              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'Próximamente',
                subTitle: 'Este mes',
                loadNextPage: () {
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
                }
              ),

              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'Populares',
                // subTitle: '',
                loadNextPage: () {
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
                }
              ),

              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'Mejor calificadas',
                // subTitle: '',
                loadNextPage: () {
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
                }
              ),

              const SizedBox(height: 20),
        
            ],
          );
        },

        childCount: 1
        ))
      ],
    );
  }
}
