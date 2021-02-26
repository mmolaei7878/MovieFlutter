import 'package:calculater_app/Models/MoviesModel.dart';
import 'package:flutter/cupertino.dart';
import '../DataBase/DBHelper.dart';

class DBProvider with ChangeNotifier {
  List<MoviesModel> _saveMovies = [];
  List<MoviesModel> get saveMovies {
    return [..._saveMovies];
  }

  Future<void> addtoSaves(MoviesModel modelMovie) async {
    await DBHelper.insert({
      'id': modelMovie.id,
      'original_language': modelMovie.original_language,
      'original_title': modelMovie.original_title,
      'overview': modelMovie.overview,
      'popularity': modelMovie.popularity,
      'poster_path': modelMovie.poster_path,
      'release_date': modelMovie.release_date,
      'title': modelMovie.title,
      'vote_count': modelMovie.vote_count,
    });

    notifyListeners();
  }

  Future<void> fetchDataBase() async {
    final dataList = await DBHelper.fetchData();
    _saveMovies = dataList
        .map((e) => MoviesModel(
            id: e['id'],
            original_language: e['original_language'],
            original_title: e['original_title'],
            overview: e['overview'],
            popularity: e['popularity'],
            poster_path: e['poster_path'],
            release_date: e['release_date'],
            title: e['title'],
            vote_count: e['vote_count']))
        .toList();
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await DBHelper.delete(id);
    notifyListeners();
  }
}
