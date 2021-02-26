import 'package:calculater_app/Models/GenerResponse.dart';
import 'package:calculater_app/Repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class GenerBloc {
  BehaviorSubject<GenerResponse> _generSubject =
      BehaviorSubject<GenerResponse>();
  final Repository _repository = Repository();

  getGeners() async {
    GenerResponse response = await _repository.getGener();
    _generSubject.sink.add(response);
  }

  BehaviorSubject<GenerResponse> get generSubject => _generSubject.stream;
  close() {
    _generSubject.close();
  }
}

final generBloc = GenerBloc();
