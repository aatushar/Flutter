/// images : "complain_116520912402073018414.jpeg"
/// desc : null

class ComplainImageListModel {
  ComplainImageListModel({
      String? images, 
      dynamic desc,}){
    _images = images;
    _desc = desc;
}

  ComplainImageListModel.fromJson(dynamic json) {
    _images = json['images'];
    _desc = json['desc'];
  }
  String? _images;
  dynamic _desc;

  String? get images => _images;
  dynamic get desc => _desc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['images'] = _images;
    map['desc'] = _desc;
    return map;
  }

}