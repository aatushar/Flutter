/// bill_master_id : 1
/// bill_child_id : 1
/// billing_dept_id : 1
/// billing_dept_name : "Revenue Dept"
/// billing_name : "Outstanding"
/// bill_cycle_name : "Mar 22"
/// shop_id : 4
/// shop_new_num : "A/1"
/// currency : "BDT"
/// amount : 3

class ShopPayableBillList {
  ShopPayableBillList({
    int? billMasterId,
    int? billChildId,
    int? billingDeptId,
    String? billingDeptName,
    String? billingName,
    String? billCycleName,
    int? shopId,
    String? shopNewNum,
    String? RoadNo,
    String? currency,
    dynamic? amount,
    dynamic? total_bill_amount,
    dynamic? penalty,
    int? billCycleId,
    bool? isCheck,
    bool? isCheckChild,
    String? dueDate,
    String? discountDate,
    dynamic? weavedAmount,
  }){
    _billMasterId = billMasterId;
    _billChildId = billChildId;
    _billingDeptId = billingDeptId;
    _billingDeptName = billingDeptName;
    _billingName = billingName;
    _billCycleName = billCycleName;
    _shopId = shopId;
    _shopNewNum = shopNewNum;
    _RoadNo = RoadNo;
    _currency = currency;
    _amount = amount;
    _totalBillAmount = totalBillAmount;
    _penalty = penalty;
    _billCycleId = billCycleId;
    _isCheck = isCheck;
    _isCheckChild = isCheckChild;
    _dueDate = dueDate;
    _discountDate = discountDate;
    _weavedAmount = weavedAmount;
  }

  ShopPayableBillList.fromJson(dynamic json) {
    _billMasterId = json['bill_master_id'];
    _billChildId = json['bill_child_id'];
    _billingDeptId = json['billing_dept_id'];
    _billingDeptName = json['billing_dept_name'];
    _billingName = json['billing_name'];
    _billCycleName = json['bill_cycle_name'];
    _shopId = json['shop_id'];
    _shopNewNum = json['shop_new_num'];
    _RoadNo = json['road_no'];
    _currency = json['currency'];
    _amount = json['amount'];
    _totalBillAmount = json['total_bill_amount'];
    _penalty = json['penalty'];
    _billCycleId = json['bill_cycle_id'];
    _isCheck = json['isCheck'];
    _isCheckChild = json['isCheckChild'];
    _dueDate = json['due_date'];
    _discountDate = json['discount_date'];
    _weavedAmount = json['weaved_amount'];
  }
  int? _billMasterId;
  int? _billChildId;
  int? _billingDeptId;
  String? _billingDeptName;
  String? _billingName;
  String? _billCycleName;
  int? _shopId;
  String? _shopNewNum;
  String? _RoadNo;
  String? _currency;
  dynamic? _amount;
  dynamic? _totalBillAmount;
  dynamic? _penalty;
  int? _billCycleId;
  bool? _isCheck;
  bool? _isCheckChild;
  String? _dueDate;
  String? _discountDate;
  dynamic? _weavedAmount;

  int? get billMasterId => _billMasterId;
  int? get billChildId => _billChildId;
  int? get billingDeptId => _billingDeptId;
  String? get billingDeptName => _billingDeptName;
  String? get billingName => _billingName;
  String? get billCycleName => _billCycleName;
  int? get shopId => _shopId;
  String? get shopNewNum => _shopNewNum;
  String? get RoadNo => _RoadNo;
  String? get currency => _currency;
  dynamic? get amount => _amount;
  dynamic? get totalBillAmount => _totalBillAmount;
  dynamic? get penalty => _penalty;
  int? get billCycleId => _billCycleId;
  bool? get isCheck => _isCheck;
  bool? get isCheckChild => _isCheckChild;
  String? get dueDate => _dueDate;
  String? get discountDate => _discountDate;
  dynamic? get weavedAmount => _weavedAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_master_id'] = _billMasterId;
    map['bill_child_id'] = _billChildId;
    map['billing_dept_id'] = _billingDeptId;
    map['billing_dept_name'] = _billingDeptName;
    map['billing_name'] = _billingName;
    map['bill_cycle_name'] = _billCycleName;
    map['shop_id'] = _shopId;
    map['shop_new_num'] = _shopNewNum;
    map['road_no'] = _RoadNo;
    map['currency'] = _currency;
    map['amount'] = _amount;
    map['total_bill_amount'] = _totalBillAmount;
    map['penalty'] = _penalty;
    map['bill_cycle_id'] = billCycleId;
    map['isCheck'] = isCheck;
    map['isCheckChild'] = isCheckChild;
    map['dueDate'] = dueDate;
    map['discountDate'] = discountDate;
    map['weavedAmount'] = weavedAmount;
    return map;
  }

}