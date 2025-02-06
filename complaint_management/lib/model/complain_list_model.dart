/// id : 25
/// title : "new test"
/// description : "new test"
/// complain_date : "2022-05-09 13:50:38"
/// created_at : null
/// short_desc : "new test"
/// diff_time : "1 hours ago"

class ComplainListModel {
  ComplainListModel({
      int? id, 
      String? title, 
      String? description, 
      String? complainDate, 
      dynamic createdAt, 
      String? shortDesc, 
      String? diffTime,}){
    _id = id;
    _title = title;
    _description = description;
    _complainDate = complainDate;
    _createdAt = createdAt;
    _shortDesc = shortDesc;
    _diffTime = diffTime;
}

  ComplainListModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _complainDate = json['complain_date'];
    _createdAt = json['created_at'];
    _shortDesc = json['short_desc'];
    _diffTime = json['diff_time'];
  }
  int? _id;
  String? _title;
  String? _description;
  String? _complainDate;
  dynamic _createdAt;
  String? _shortDesc;
  String? _diffTime;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get complainDate => _complainDate;
  dynamic get createdAt => _createdAt;
  String? get shortDesc => _shortDesc;
  String? get diffTime => _diffTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['complain_date'] = _complainDate;
    map['created_at'] = _createdAt;
    map['short_desc'] = _shortDesc;
    map['diff_time'] = _diffTime;
    return map;
  }

}