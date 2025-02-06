/// id : 1
/// revenue_source_id : 2
/// revenue_head_name : "Utility Charge"
/// revenue_head_name_bn : "Utility Charge"
/// calculated : 0

class RevenueSourceHead {
  RevenueSourceHead({
      int? id, 
      int? revenueSourceId, 
      String? revenueHeadName, 
      String? revenueHeadNameBn, 
      int? calculated,}){
    _id = id;
    _revenueSourceId = revenueSourceId;
    _revenueHeadName = revenueHeadName;
    _revenueHeadNameBn = revenueHeadNameBn;
    _calculated = calculated;
}

  RevenueSourceHead.fromJson(dynamic json) {
    _id = json['id'];
    _revenueSourceId = json['revenue_source_id'];
    _revenueHeadName = json['revenue_head_name'];
    _revenueHeadNameBn = json['revenue_head_name_bn'];
    _calculated = json['calculated'];
  }
  int? _id;
  int? _revenueSourceId;
  String? _revenueHeadName;
  String? _revenueHeadNameBn;
  int? _calculated;

  int? get id => _id;
  int? get revenueSourceId => _revenueSourceId;
  String? get revenueHeadName => _revenueHeadName;
  String? get revenueHeadNameBn => _revenueHeadNameBn;
  int? get calculated => _calculated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['revenue_source_id'] = _revenueSourceId;
    map['revenue_head_name'] = _revenueHeadName;
    map['revenue_head_name_bn'] = _revenueHeadNameBn;
    map['calculated'] = _calculated;
    return map;
  }

}