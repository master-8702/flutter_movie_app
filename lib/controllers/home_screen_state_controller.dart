import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_movie_app/models/home_screen_state.dart';
import 'package:get_it/get_it.dart';

class HomeScreenStateController extends StateNotifier<HomeScreenState> {
  HomeScreenStateController([HomeScreenState? state])
      : super(state ?? HomeScreenState.initial()) {
    getMovies();
  }

  // getting the global movie service here
  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> _movies = [];
      _movies = await _movieService.getLatestMovies(page: state.currentPage);
    } catch (e) {}
  }
}
