import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/constants/movie_category.dart';

class HomeScreenState {
  final List<Movie>? movies;
  final int? currentPage;
  final String? searchCategory;
  final String? searchQuery;

  HomeScreenState({
    this.movies,
    this.currentPage,
    this.searchCategory,
    this.searchQuery,
  });

  // initial state of home screen
  HomeScreenState.initial()
      : movies = [],
        currentPage = 1,
        searchCategory = MovieCategory.latest,
        searchQuery = '';

// copy with method that we are going to use when the state is partially or
// fully changed
  HomeScreenState copyWith(
      {List<Movie>? movies,
      int? currentPage,
      String? searchCategory,
      String? searchQuery}) {
    return HomeScreenState(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      searchCategory: searchCategory ?? this.searchCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
