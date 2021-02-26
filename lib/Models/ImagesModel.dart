class ImagesModel {
  final int id;
  final List backdrops;
  final List posters;
  ImagesModel({this.backdrops, this.id, this.posters});
  ImagesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        backdrops = json['backdrops'],
        posters = json['posters'];
}
