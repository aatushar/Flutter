/// id : 24
/// revenue_source_id : 2
/// shop_name : "Shawon"
/// shop_name_bn : "Shawon"
/// shop_type_id : 3
/// floor_no : "Road no 20"
/// shutter_type : "Plot no 10"
/// shop_new_num : "Flat no A/10"
/// shop_old_num : null
/// user_id : 11
/// user_name : "Shawon"

class ShopListModel {
  ShopListModel({
    int? id,
    int? revenueSourceId,
    String? shopName,
    String? shopNameBn,
    String? shopNewNum,
    String? shopTypeName,
    String? shopTypeNameBn,}){
    _id = id;
    _revenueSourceId = revenueSourceId;
    _shopName = shopName;
    _shopNameBn = shopNameBn;
    _shopNewNum = shopNewNum;
    _shopTypeName = shopTypeName;
    _shopTypeNameBn = shopTypeNameBn;
}

  ShopListModel.fromJson(dynamic json) {
    _id = json['id'];
    _revenueSourceId = json['revenue_source_id'];
    _shopName = json['shop_name'];
    _shopNameBn = json['shop_name_bn'];
    _shopNewNum = json['shop_new_num'];
    _shopTypeName = json['shop_type_name'];
    _shopTypeNameBn = json['shop_type_name_bn'];
  }
  int? _id;
  int? _revenueSourceId;
  String? _shopName;
  String? _shopNameBn;
  String? _shopNewNum;
  String? _shopTypeName;
  String? _shopTypeNameBn;

  int? get id => _id;
  int? get revenueSourceId => _revenueSourceId;
  String? get shopName => _shopName;
  String? get shopNameBn => _shopNameBn;
  String? get shopNewNum => _shopNewNum;
  String? get shopTypeName => _shopTypeName;
  String? get shopTypeNameBn => _shopTypeNameBn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['revenue_source_id'] = _revenueSourceId;
    map['shop_name'] = _shopName;
    map['shop_name_bn'] = _shopNameBn;
    map['shop_new_num'] = _shopNewNum;
    map['shop_type_name'] = _shopTypeName;
    map['shop_type_name_bn'] = _shopTypeNameBn;
    return map;
  }
}