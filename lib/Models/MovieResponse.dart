import 'package:calculater_app/Models/MoviesModel.dart';

class MovieResponse {
  final List<MoviesModel> moviesList;
  MovieResponse({this.moviesList});
  MovieResponse.fromJson(Map<String, dynamic> json)
      : moviesList = (json['results'] as List)
            .map((e) => MoviesModel.fromJson(e))
            .toList();
}
