/// id : 2
/// institute_id : 7
/// revenue_source_name : "TAX from DOHS Savar"
/// revenue_source_name_bn : "TAX from DOHS Savar"

class RevenueSorceModel {
  RevenueSorceModel({
      int? id, 
      int? instituteId, 
      String? revenueSourceName, 
      String? revenueSourceNameBn,}){
    _id = id;
    _instituteId = instituteId;
    _revenueSourceName = revenueSourceName;
    _revenueSourceNameBn = revenueSourceNameBn;
}

  RevenueSorceModel.fromJson(dynamic json) {
    _id = json['id'];
    _instituteId = json['institute_id'];
    _revenueSourceName = json['revenue_source_name'];
    _revenueSourceNameBn = json['revenue_source_name_bn'];
  }
  int? _id;
  int? _instituteId;
  String? _revenueSourceName;
  String? _revenueSourceNameBn;

  int? get id => _id;
  int? get instituteId => _instituteId;
  String? get revenueSourceName => _revenueSourceName;
  String? get revenueSourceNameBn => _revenueSourceNameBn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['institute_id'] = _instituteId;
    map['revenue_source_name'] = _revenueSourceName;
    map['revenue_source_name_bn'] = _revenueSourceNameBn;
    return map;
  }

}