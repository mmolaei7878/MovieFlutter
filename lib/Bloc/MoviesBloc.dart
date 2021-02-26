import 'package:calculater_app/Models/MovieResponse.dart';
import 'package:calculater_app/Repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  final BehaviorSubject<MovieResponse> _subjectSlider =
      BehaviorSubject<MovieResponse>();

  final BehaviorSubject<MovieResponse> _searchSubject =
      BehaviorSubject<MovieResponse>();

  final BehaviorSubject<MovieResponse> _gridViewMovies =
      BehaviorSubject<MovieResponse>();

  final Repository repository = Repository();

  BehaviorSubject<MovieResponse> get subject => _subject;
  BehaviorSubject<MovieResponse> get subjectSlider => _subjectSlider;
  BehaviorSubject<MovieResponse> get searchSubject => _searchSubject;
  BehaviorSubject<MovieResponse> get gridViewMovies => _gridViewMovies;

  getBlocMovies({int page}) async {
    MovieResponse response = await repository.getRepositoryMovies(page: page);
    _subject.sink.add(response);
  }

  getGridViewMovies({String urlSegment = 'latest'}) async {
    MovieResponse response =
        await repository.getGridViewMovies(urlSegment: urlSegment);
    _gridViewMovies.sink.add(response);
  }

  getMoviesSearched(String query, int page) async {
    MovieResponse response = await repository.searchMovies(query, page);

    _searchSubject.sink.add(response);
  }

  getDiscoverMovies({int page}) async {
    MovieResponse response = await repository.getDiscover(page);
    _subjectSlider.sink.add(response);
  }

  close() {
    _subject.close();
    _subjectSlider.close();
    _searchSubject.close();
    _gridViewMovies.close();
  }
}

final moviesBloc = MoviesBloc();
