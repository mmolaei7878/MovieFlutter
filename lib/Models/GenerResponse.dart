import 'package:calculater_app/Models/GenerModel.dart';

class GenerResponse {
  final List<GenerModel> genersList;
  GenerResponse({this.genersList});
  GenerResponse.fromJson(Map<String, dynamic> json)
      : genersList = (json["genres"] as List)
            .map((i) => new GenerModel.fromJson(i))
            .toList();
}
