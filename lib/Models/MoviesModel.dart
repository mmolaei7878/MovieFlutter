class MoviesModel {
  final bool adult;
  final int id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String poster_path;
  final String release_date;
  final String title;
  final bool video;
  final int vote_count;

  MoviesModel(
      {this.adult,
      this.id,
      this.original_language,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.release_date,
      this.title,
      this.video,
      this.vote_count});

  MoviesModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        id = json['id'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        overview = json['overview'],
        popularity = (json['popularity']).toDouble(),
        poster_path = json['poster_path'],
        release_date = json['release_date'],
        title = json['title'],
        video = json['video'],
        vote_count = json['vote_count'];
}
