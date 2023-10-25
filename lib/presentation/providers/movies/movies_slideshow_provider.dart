
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';
import '../../../domain/entities/movie.dart';


final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

  final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0,6);

});