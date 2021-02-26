import 'dart:io';

import 'package:calculater_app/Models/GenerResponse.dart';
import 'dart:collection';
import 'package:calculater_app/Models/MovieResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/SearchModel.dart';
import 'package:path_provider/path_provider.dart';

class Repository {
  HashMap<int, MovieResponse> _hashMapDiscoverMovies =
      HashMap<int, MovieResponse>();
  HashMap<int, MovieResponse> _hashMapGridViewMovies =
      HashMap<int, MovieResponse>();
  HashMap<int, GenerResponse> _hashMapGeners = HashMap<int, GenerResponse>();

  static const String api_Key = "<<Your Api Key>>";

  var searchModel = SearchModel();

  Future<MovieResponse> getRepositoryMovies({int page = 1}) async {
    String fileName = 'pathString.json';
    final dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      final data = file.readAsStringSync();
      final result = json.decode(data);
      return MovieResponse.fromJson((result as Map<String, dynamic>));
    } else {
      final url =
          'https://api.themoviedb.org/3/movie/now_playing?api_key=$api_Key&language=en-US&page=1';

      final response = await http.get(url);

      print(json.decode(response.body));

      final extractedData = json.decode(response.body);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      return MovieResponse.fromJson((extractedData as Map<String, dynamic>));
    }
  }

  Future<MovieResponse> getGridViewMovies({String urlSegment}) async {
    if (!_hashMapGridViewMovies.containsKey(urlSegment)) {
      final url =
          'https://api.themoviedb.org/3/movie/$urlSegment?api_key=$api_Key&language=en-US&page=5';

      final response = await http.get(url);

      print(json.decode(response.body));
      return MovieResponse.fromJson(
          (json.decode(response.body) as Map<String, dynamic>));
    }
    return _hashMapGridViewMovies[urlSegment];
  }

  Future<MovieResponse> getDiscover(int page) async {
    if (!_hashMapDiscoverMovies.containsKey(page)) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$api_Key&language=en-US&page=$page';
      final response = await http.get(url);
      print(json.decode(response.body));
      _hashMapDiscoverMovies[page] = MovieResponse.fromJson(
          (json.decode(response.body) as Map<String, dynamic>));
    }
    return _hashMapDiscoverMovies[page];
  }

  Future<GenerResponse> getGener() async {
    if (!_hashMapGeners.containsKey(api_Key)) {
      final url =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=$api_Key&language=en-US';
      final response = await http.get(url);
      print(json.decode(response.body));
      return GenerResponse.fromJson(
          (json.decode(response.body) as Map<String, dynamic>));
    } else {
      return _hashMapGeners[api_Key];
    }
  }

  Future<MovieResponse> searchMovies(String query, int page) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$api_Key&language=en-US&page=$page&include_adult=true&query=$query';
    final response = await http.get(url);
    print(json.decode(response.body));
    searchModel = SearchModel(
        page: json.decode(response.body)['page'],
        total_pages: json.decode(response.body)['total_pages'],
        total_result: json.decode(response.body)['total_results']);
    return MovieResponse.fromJson(
        (json.decode(response.body) as Map<String, dynamic>));
  }
}
