class SearchModel {
  final int page;
  final int total_pages;
  final int total_result;
  SearchModel({this.page, this.total_pages, this.total_result});
  SearchModel.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        total_pages = json['total_page'],
        total_result = json['total_result'];
}
