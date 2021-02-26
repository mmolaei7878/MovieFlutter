import 'package:calculater_app/Models/ImagesModel.dart';

class ImagesResponse {
  List<ImagesModel> imagesModel;
  ImagesResponse({this.imagesModel});
  ImagesResponse.fromJson(List list)
      : imagesModel = list.map((e) => ImagesModel.fromJson(e)).toList();
}
