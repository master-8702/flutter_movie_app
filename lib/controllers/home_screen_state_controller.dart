import 'package:flutter/foundation.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/services/movie_service.dart';
import 'package:flutter_movie_app/models/home_screen_state.dart';
import 'package:flutter_movie_app/constants/movie_category.dart';

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

      if (state.searchQuery!.isEmpty) {
        if (state.searchCategory == MovieCategory.inTheatre) {
          _movies =
              await _movieService.getInTheatreMovies(page: state.currentPage);
        } else if (state.searchCategory == MovieCategory.popular) {
          _movies =
              await _movieService.getPopularMovies(page: state.currentPage);
        } else if (state.searchCategory == MovieCategory.topRated) {
          _movies =
              await _movieService.getTopRatedMovies(page: state.currentPage);
        } else if (state.searchCategory == MovieCategory.upcoming) {
          _movies =
              await _movieService.getUpcomingMovies(page: state.currentPage);
        } else if (state.searchCategory == MovieCategory.none) {
          _movies = [];
        }
      } else {
        // if non is selected we will search a movie
        _movies = await _movieService.searchMovies(state.searchQuery);
      }

      // setting (updating) state
      // here we will increment the currentPage variable by one in order to
      // facilitate for the next fetch request, so that when we want to fetch
      // the next page (set of movies) we will just call getMovies().
      state = state.copyWith(
        movies: [
          ...state.movies!,
          ..._movies,
        ],
        currentPage: state.currentPage! + 1,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateMovieCategory(String _category) {
    try {
      state = state.copyWith(
          movies: [],
          currentPage: 1,
          searchCategory: _category,
          searchQuery: '');

      getMovies();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateMovieSearchText(String _searchQuery) {
    try {
      state = state.copyWith(
          movies: [],
          currentPage: 1,
          searchCategory: MovieCategory.none,
          searchQuery: _searchQuery);

      getMovies();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// home screen state controller provider
final homeScreenStateControllerProvider =
    StateNotifierProvider<HomeScreenStateController, HomeScreenState>((ref) {
  return HomeScreenStateController();
});
