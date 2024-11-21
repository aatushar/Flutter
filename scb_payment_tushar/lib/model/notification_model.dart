/// revenue_source_id : 1
/// billing_dept_id : 1
/// title : "My title"
/// desc : "Hello, this is my description for testing with mobile app"
/// type : 2
/// notify_date : "2022-05-06 11:08:29"
/// created_at : "2022-05-06 11:47:29"
/// short_desc : "Hello, this is my de"
/// diff_time : "27 min ago"

class NotificationModel {
  NotificationModel({
      int? id,
      int? revenueSourceId,
      int? billingDeptId,
      String? title, 
      String? desc, 
      int? type, 
      String? notifyDate, 
      String? createdAt, 
      String? shortDesc, 
      String? diffTime,}){
    _id = id;
    _revenueSourceId = revenueSourceId;
    _billingDeptId = billingDeptId;
    _title = title;
    _desc = desc;
    _type = type;
    _notifyDate = notifyDate;
    _createdAt = createdAt;
    _shortDesc = shortDesc;
    _diffTime = diffTime;
}

  NotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _revenueSourceId = json['revenue_source_id'];
    _billingDeptId = json['billing_dept_id'];
    _title = json['title'];
    _desc = json['desc'];
    _type = json['type'];
    _notifyDate = json['notify_date'];
    _createdAt = json['created_at'];
    _shortDesc = json['short_desc'];
    _diffTime = json['diff_time'];
  }
  int? _id;
  int? _revenueSourceId;
  int? _billingDeptId;
  String? _title;
  String? _desc;
  int? _type;
  String? _notifyDate;
  String? _createdAt;
  String? _shortDesc;
  String? _diffTime;

  int? get id => _id;
  int? get revenueSourceId => _revenueSourceId;
  int? get billingDeptId => _billingDeptId;
  String? get title => _title;
  String? get desc => _desc;
  int? get type => _type;
  String? get notifyDate => _notifyDate;
  String? get createdAt => _createdAt;
  String? get shortDesc => _shortDesc;
  String? get diffTime => _diffTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['revenue_source_id'] = _revenueSourceId;
    map['billing_dept_id'] = _billingDeptId;
    map['title'] = _title;
    map['desc'] = _desc;
    map['type'] = _type;
    map['notify_date'] = _notifyDate;
    map['created_at'] = _createdAt;
    map['short_desc'] = _shortDesc;
    map['diff_time'] = _diffTime;
    return map;
  }

}