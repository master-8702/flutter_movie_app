import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_movie_app/models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getit = GetIt.instance;

  String? _base_url;
  String? _api_key;

  HTTPService() {
    AppConfig _config = getit.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  Future<Response?> get(String _path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_base_url$_path';
      Map<String, dynamic> _query = {'api_key': _api_key, 'language': 'en-US'};

      // if optional query is passed we will append it on the existing {_query}
      if (query != null) {
        _query.addAll(query);
      }

      return await dio.get(_url, queryParameters: _query);
    } catch (e) {
      debugPrint('Error Occured, $e');
    }
  }
}
