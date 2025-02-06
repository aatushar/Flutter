/// sourceList : [{"id":2,"institute_id":7,"revenue_source_name":"TAX from DOHS Savar","revenue_source_name_bn":"TAX from DOHS Savar","created_by":"1","updated_by":null,"created_at":"2022-01-08 12:36:07","updated_at":"2022-01-08 12:35:03","institute_info_id":1}]
/// sourceHeadList : [{"id":1,"revenue_source_id":2,"revenue_head_name":"Utility Charge","revenue_head_name_bn":"Utility Charge","calculated":0,"created_by":"1","updated_by":"1","created_at":"2022-01-08 12:37:21","updated_at":"2022-01-17 21:21:24","revenue_source_id1":1},{"id":2,"revenue_source_id":2,"revenue_head_name":"Monthly Charge","revenue_head_name_bn":"Monthly Charge","calculated":0,"created_by":"1","updated_by":"1","created_at":"2022-01-08 12:37:21","updated_at":"2022-01-17 21:21:17","revenue_source_id1":1},{"id":3,"revenue_source_id":2,"revenue_head_name":"Electric Bill","revenue_head_name_bn":"Electric Bill","calculated":1,"created_by":"1","updated_by":"1","created_at":"2022-01-08 12:37:21","updated_at":"2022-01-17 21:21:11","revenue_source_id1":1},{"id":4,"revenue_source_id":2,"revenue_head_name":"Holding TAX","revenue_head_name_bn":"Holding TAX","calculated":1,"created_by":"1","updated_by":"1","created_at":"2022-01-08 12:37:21","updated_at":"2022-01-17 21:21:04","revenue_source_id1":1}]

class SourceListModel {
  SourceListModel({
      List<SourceList>? sourceList, 
      List<SourceHeadList>? sourceHeadList,}){
    _sourceList = sourceList;
    _sourceHeadList = sourceHeadList;
}

  SourceListModel.fromJson(dynamic json) {
    if (json['sourceList'] != null) {
      _sourceList = [];
      json['sourceList'].forEach((v) {
        _sourceList?.add(SourceList.fromJson(v));
      });
    }
    if (json['sourceHeadList'] != null) {
      _sourceHeadList = [];
      json['sourceHeadList'].forEach((v) {
        _sourceHeadList?.add(SourceHeadList.fromJson(v));
      });
    }
  }
  List<SourceList>? _sourceList;
  List<SourceHeadList>? _sourceHeadList;

  List<SourceList>? get sourceList => _sourceList;
  List<SourceHeadList>? get sourceHeadList => _sourceHeadList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sourceList != null) {
      map['sourceList'] = _sourceList?.map((v) => v.toJson()).toList();
    }
    if (_sourceHeadList != null) {
      map['sourceHeadList'] = _sourceHeadList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// revenue_source_id : 2
/// revenue_head_name : "Utility Charge"
/// revenue_head_name_bn : "Utility Charge"
/// calculated : 0
/// created_by : "1"
/// updated_by : "1"
/// created_at : "2022-01-08 12:37:21"
/// updated_at : "2022-01-17 21:21:24"
/// revenue_source_id1 : 1

class SourceHeadList {
  SourceHeadList({
      int? id, 
      int? revenueSourceId, 
      String? revenueHeadName, 
      String? revenueHeadNameBn, 
      int? calculated, 
      String? createdBy, 
      String? updatedBy, 
      String? createdAt, 
      String? updatedAt, 
      int? revenueSourceId1,}){
    _id = id;
    _revenueSourceId = revenueSourceId;
    _revenueHeadName = revenueHeadName;
    _revenueHeadNameBn = revenueHeadNameBn;
    _calculated = calculated;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _revenueSourceId1 = revenueSourceId1;
}

  SourceHeadList.fromJson(dynamic json) {
    _id = json['id'];
    _revenueSourceId = json['revenue_source_id'];
    _revenueHeadName = json['revenue_head_name'];
    _revenueHeadNameBn = json['revenue_head_name_bn'];
    _calculated = json['calculated'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _revenueSourceId1 = json['revenue_source_id1'];
  }
  int? _id;
  int? _revenueSourceId;
  String? _revenueHeadName;
  String? _revenueHeadNameBn;
  int? _calculated;
  String? _createdBy;
  String? _updatedBy;
  String? _createdAt;
  String? _updatedAt;
  int? _revenueSourceId1;

  int? get id => _id;
  int? get revenueSourceId => _revenueSourceId;
  String? get revenueHeadName => _revenueHeadName;
  String? get revenueHeadNameBn => _revenueHeadNameBn;
  int? get calculated => _calculated;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get revenueSourceId1 => _revenueSourceId1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['revenue_source_id'] = _revenueSourceId;
    map['revenue_head_name'] = _revenueHeadName;
    map['revenue_head_name_bn'] = _revenueHeadNameBn;
    map['calculated'] = _calculated;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['revenue_source_id1'] = _revenueSourceId1;
    return map;
  }

}

/// id : 2
/// institute_id : 7
/// revenue_source_name : "TAX from DOHS Savar"
/// revenue_source_name_bn : "TAX from DOHS Savar"
/// created_by : "1"
/// updated_by : null
/// created_at : "2022-01-08 12:36:07"
/// updated_at : "2022-01-08 12:35:03"
/// institute_info_id : 1

class SourceList {
  SourceList({
      int? id, 
      int? instituteId, 
      String? revenueSourceName, 
      String? revenueSourceNameBn, 
      String? createdBy, 
      dynamic updatedBy, 
      String? createdAt, 
      String? updatedAt, 
      int? instituteInfoId,}){
    _id = id;
    _instituteId = instituteId;
    _revenueSourceName = revenueSourceName;
    _revenueSourceNameBn = revenueSourceNameBn;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _instituteInfoId = instituteInfoId;
}

  SourceList.fromJson(dynamic json) {
    _id = json['id'];
    _instituteId = json['institute_id'];
    _revenueSourceName = json['revenue_source_name'];
    _revenueSourceNameBn = json['revenue_source_name_bn'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _instituteInfoId = json['institute_info_id'];
  }
  int? _id;
  int? _instituteId;
  String? _revenueSourceName;
  String? _revenueSourceNameBn;
  String? _createdBy;
  dynamic _updatedBy;
  String? _createdAt;
  String? _updatedAt;
  int? _instituteInfoId;

  int? get id => _id;
  int? get instituteId => _instituteId;
  String? get revenueSourceName => _revenueSourceName;
  String? get revenueSourceNameBn => _revenueSourceNameBn;
  String? get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get instituteInfoId => _instituteInfoId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['institute_id'] = _instituteId;
    map['revenue_source_name'] = _revenueSourceName;
    map['revenue_source_name_bn'] = _revenueSourceNameBn;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['institute_info_id'] = _instituteInfoId;
    return map;
  }

}