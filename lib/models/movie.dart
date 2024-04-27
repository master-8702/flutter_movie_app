import 'package:get_it/get_it.dart';

import 'package:flutter_movie_app/models/app_config.dart';

class Movie {
  final String title;
  final String language;
  final bool isAdult;
  final String description;
  final String? posterPath;
  final String? backdropPath;
  final num rating;
  final String releaseDate;

  Movie(
      {this.title = 'NA',
      this.language = 'NA',
      this.isAdult = false,
      this.description = 'NA',
      this.posterPath,
      this.backdropPath,
      this.rating = 0,
      this.releaseDate = 'NA'});

  factory Movie.fromJson(Map<String, dynamic> _json) {
    return Movie(
      title: _json['title'],
      language: _json['original_language'],
      isAdult: _json['adult'],
      description: _json['overview'],
      posterPath: _json['poster_path'],
      backdropPath: _json['backdrop_path'],
      rating: _json['vote_average'],
      releaseDate: _json['release_date'],
    );
  }

  // helper method

  String posterUrl() {
    final AppConfig _appConfig = GetIt.instance.get<AppConfig>();

    return '${_appConfig.BASE_IMAGE_API_URL}$posterPath';
  }
}
