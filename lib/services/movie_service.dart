import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getInTheatreMovies({int? page}) async {
    Response? _response = await _http.get('/movie/now_playing', query: {
      'page': page,
    });

    if (_response != null && _response.statusCode == 200) {
      Map _data = _response.data;
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Can not load movies that are currently in theatre');
    }
  }

  Future<List<Movie>> getPopularMovies({int? page}) async {
    Response? _response = await _http.get('/movie/popular', query: {
      'page': page,
    });

    if (_response != null && _response.statusCode == 200) {
      Map _data = _response.data;
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Can not load popular movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies({int? page}) async {
    Response? _response = await _http.get('/movie/top_rated', query: {
      'page': page,
    });

    if (_response != null && _response.statusCode == 200) {
      Map _data = _response.data;
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Can not load top rated movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies({int? page}) async {
    Response? _response = await _http.get('/movie/upcoming', query: {
      'page': page,
    });

    if (_response != null && _response.statusCode == 200) {
      Map _data = _response.data;
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Can not load upcoming movies');
    }
  }
}
