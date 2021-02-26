class GenerModel {
  final int id;
  final String name;
  GenerModel({this.id, this.name});
  GenerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
