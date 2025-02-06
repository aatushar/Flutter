/// id : 8
/// bill_month_id : 3
/// shop_id : 14
/// created_by : "1"
/// updated_by : null
/// created_at : "2022-01-17 21:45:31"
/// updated_at : null
/// bill_month : "TAX Year 2021-2022"
/// shop_name : "null"
/// shop_new_num : "Flat No A/02"
/// revenue_head_name : "Holding TAX"
/// bill_child_id : 2
/// revenue_head_id : 4
/// amount : 15
/// currency : "BDT"

class PayableBillModel {
  PayableBillModel({
      int? id, 
      int? billMonthId, 
      int? shopId, 
      String? createdBy, 
      dynamic updatedBy, 
      String? createdAt, 
      dynamic updatedAt, 
      String? billMonth, 
      String? shopName, 
      String? shopNewNum, 
      String? revenueHeadName, 
      int? billChildId, 
      int? revenueHeadId, 
      int? amount, 
      String? currency,}){
    _id = id;
    _billMonthId = billMonthId;
    _shopId = shopId;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _billMonth = billMonth;
    _shopName = shopName;
    _shopNewNum = shopNewNum;
    _revenueHeadName = revenueHeadName;
    _billChildId = billChildId;
    _revenueHeadId = revenueHeadId;
    _amount = amount;
    _currency = currency;
}

  PayableBillModel.fromJson(dynamic json) {
    _id = json['id'];
    _billMonthId = json['bill_month_id'];
    _shopId = json['shop_id'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _billMonth = json['bill_month'];
    _shopName = json['shop_name'];
    _shopNewNum = json['shop_new_num'];
    _revenueHeadName = json['revenue_head_name'];
    _billChildId = json['bill_child_id'];
    _revenueHeadId = json['revenue_head_id'];
    _amount = json['amount'];
    _currency = json['currency'];
  }
  int? _id;
  int? _billMonthId;
  int? _shopId;
  String? _createdBy;
  dynamic _updatedBy;
  String? _createdAt;
  dynamic _updatedAt;
  String? _billMonth;
  String? _shopName;
  String? _shopNewNum;
  String? _revenueHeadName;
  int? _billChildId;
  int? _revenueHeadId;
  int? _amount;
  String? _currency;

  int? get id => _id;
  int? get billMonthId => _billMonthId;
  int? get shopId => _shopId;
  String? get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  String? get billMonth => _billMonth;
  String? get shopName => _shopName;
  String? get shopNewNum => _shopNewNum;
  String? get revenueHeadName => _revenueHeadName;
  int? get billChildId => _billChildId;
  int? get revenueHeadId => _revenueHeadId;
  int? get amount => _amount;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bill_month_id'] = _billMonthId;
    map['shop_id'] = _shopId;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['bill_month'] = _billMonth;
    map['shop_name'] = _shopName;
    map['shop_new_num'] = _shopNewNum;
    map['revenue_head_name'] = _revenueHeadName;
    map['bill_child_id'] = _billChildId;
    map['revenue_head_id'] = _revenueHeadId;
    map['amount'] = _amount;
    map['currency'] = _currency;
    return map;
  }

}