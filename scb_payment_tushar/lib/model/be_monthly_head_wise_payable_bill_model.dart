/// bill_master_id : 38161369
/// bill_child_id : 38171118
/// billing_dept_id : 1
/// billing_dept_name : "Revenue Dept"
/// billing_name : "Monthly Service Charge- Aug-22"
/// bill_cycle_id : 82
/// bill_cycle_name : "Aug-22"
/// shop_id : 7
/// shop_new_num : "A/4"
/// road_no : "N/A"
/// shop_name : "N/A"
/// currency : "BDT"
/// penalty : "1.80"
/// weaved_amount : null
/// total_bill_amount : "3843.25"
/// amount : "3843.25"
/// amount_with_vat : null
/// total_bill_after_penalty : 3843.25
/// due_date : "2022-09-10"
/// discount_date : "2022-09-10"
/// isCheck : true
/// isCheckChild : false
/// item_row : [{"revenue_head_name":"Service Charge","calculated":0,"amount":0,"vat_amount":0,"total_bill_after_penalty":0,"total_payable":0},{"revenue_head_name":"Board Rent","calculated":0,"amount":3255,"vat_amount":0,"total_bill_after_penalty":0,"total_payable":0}]

class BeMonthlyHeadWisePayableBillModel {
  BeMonthlyHeadWisePayableBillModel({
    dynamic? billMasterId,
    dynamic? billChildId,
    dynamic? billingDeptId,
      String? billingDeptName, 
      String? billingName,
    dynamic? billCycleId,
      String? billCycleName,
    dynamic? shopId,
      String? shopNewNum, 
      String? roadNo, 
      String? shopName, 
      String? currency,
    dynamic? penalty,
    dynamic? vatAmount,
      dynamic weavedAmount,
    dynamic? totalBillAmount,
    dynamic? amount,
      dynamic amountWithVat,
    dynamic? totalBillAfterPenalty,
      String? dueDate, 
      String? discountDate, 
      bool? isPanalty,
      bool? isCheck,
      bool? isCheckChild,
      List<Item_row>? itemRow,}){
    _billMasterId = billMasterId;
    _billChildId = billChildId;
    _billingDeptId = billingDeptId;
    _billingDeptName = billingDeptName;
    _billingName = billingName;
    _billCycleId = billCycleId;
    _billCycleName = billCycleName;
    _shopId = shopId;
    _shopNewNum = shopNewNum;
    _roadNo = roadNo;
    _shopName = shopName;
    _currency = currency;
    _penalty = penalty;
    _vatAmount = vatAmount;
    _weavedAmount = weavedAmount;
    _totalBillAmount = totalBillAmount;
    _amount = amount;
    _amountWithVat = amountWithVat;
    _totalBillAfterPenalty = totalBillAfterPenalty;
    _dueDate = dueDate;
    _discountDate = discountDate;
    _isPanalty = isPanalty;
    _isCheck = isCheck;
    _isCheckChild = isCheckChild;
    _itemRow = itemRow;
}

  BeMonthlyHeadWisePayableBillModel.fromJson(dynamic json) {
    _billMasterId = json['bill_master_id'];
    _billChildId = json['bill_child_id'];
    _billingDeptId = json['billing_dept_id'];
    _billingDeptName = json['billing_dept_name'];
    _billingName = json['billing_name'];
    _billCycleId = json['bill_cycle_id'];
    _billCycleName = json['bill_cycle_name'];
    _shopId = json['shop_id'];
    _shopNewNum = json['shop_new_num'];
    _roadNo = json['road_no'];
    _shopName = json['shop_name'];
    _currency = json['currency'];
    _penalty = json['penalty'];
    _vatAmount = json['vat_amount'];
    _weavedAmount = json['weaved_amount'];
    _totalBillAmount = json['total_bill_amount'];
    _amount = json['amount'];
    _amountWithVat = json['amount_with_vat'];
    _totalBillAfterPenalty = json['total_bill_after_penalty'];
    _dueDate = json['due_date'];
    _discountDate = json['discount_date'];
    _isPanalty = json['isPanalty'];
    _isCheck = json['isCheck'];
    _isCheckChild = json['isCheckChild'];
    if (json['item_row'] != null) {
      _itemRow = [];
      json['item_row'].forEach((v) {
        _itemRow?.add(Item_row.fromJson(v));
      });
    }
  }
  dynamic? _billMasterId;
  dynamic? _billChildId;
  dynamic? _billingDeptId;
  String? _billingDeptName;
  String? _billingName;
  dynamic? _billCycleId;
  String? _billCycleName;
  dynamic? _shopId;
  String? _shopNewNum;
  String? _roadNo;
  String? _shopName;
  String? _currency;
  dynamic? _penalty;
  dynamic? _vatAmount;
  dynamic _weavedAmount;
  dynamic? _totalBillAmount;
  dynamic? _amount;
  dynamic _amountWithVat;
  dynamic? _totalBillAfterPenalty;
  String? _dueDate;
  String? _discountDate;
  bool? _isPanalty;
  bool? _isCheck;
  bool? _isCheckChild;
  List<Item_row>? _itemRow;

  dynamic? get billMasterId => _billMasterId;
  dynamic? get billChildId => _billChildId;
  dynamic? get billingDeptId => _billingDeptId;
  String? get billingDeptName => _billingDeptName;
  String? get billingName => _billingName;
  dynamic? get billCycleId => _billCycleId;
  String? get billCycleName => _billCycleName;
  dynamic? get shopId => _shopId;
  String? get shopNewNum => _shopNewNum;
  String? get roadNo => _roadNo;
  String? get shopName => _shopName;
  String? get currency => _currency;
  dynamic? get penalty => _penalty;
  dynamic? get vatAmount => _vatAmount;
  dynamic get weavedAmount => _weavedAmount;
  dynamic? get totalBillAmount => _totalBillAmount;
  dynamic? get amount => _amount;
  dynamic get amountWithVat => _amountWithVat;
  dynamic? get totalBillAfterPenalty => _totalBillAfterPenalty;
  String? get dueDate => _dueDate;
  String? get discountDate => _discountDate;
  bool? get isPanalty => _isPanalty;
  bool? get isCheck => _isCheck;
  bool? get isCheckChild => _isCheckChild;
  List<Item_row>? get itemRow => _itemRow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_master_id'] = _billMasterId;
    map['bill_child_id'] = _billChildId;
    map['billing_dept_id'] = _billingDeptId;
    map['billing_dept_name'] = _billingDeptName;
    map['billing_name'] = _billingName;
    map['bill_cycle_id'] = _billCycleId;
    map['bill_cycle_name'] = _billCycleName;
    map['shop_id'] = _shopId;
    map['shop_new_num'] = _shopNewNum;
    map['road_no'] = _roadNo;
    map['shop_name'] = _shopName;
    map['currency'] = _currency;
    map['penalty'] = _penalty;
    map['vatAmount'] = _vatAmount;
    map['weaved_amount'] = _weavedAmount;
    map['total_bill_amount'] = _totalBillAmount;
    map['amount'] = _amount;
    map['amount_with_vat'] = _amountWithVat;
    map['total_bill_after_penalty'] = _totalBillAfterPenalty;
    map['due_date'] = _dueDate;
    map['discount_date'] = _discountDate;
    map['isPanalty'] = _isPanalty;
    map['isCheck'] = _isCheck;
    map['isCheckChild'] = _isCheckChild;
    if (_itemRow != null) {
      map['item_row'] = _itemRow?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// revenue_head_name : "Service Charge"
/// calculated : 0
/// amount : 0
/// vat_amount : 0
/// total_bill_after_penalty : 0
/// total_payable : 0

class Item_row {
  Item_row({
      String? revenueHeadName, 
      int? calculated,
    dynamic? amount,
    dynamic? vatAmount,
    dynamic? totalBillAfterPenalty,
    dynamic? totalPayable,}){
    _revenueHeadName = revenueHeadName;
    _calculated = calculated;
    _amount = amount;
    _vatAmount = vatAmount;
    _totalBillAfterPenalty = totalBillAfterPenalty;
    _totalPayable = totalPayable;
}

  Item_row.fromJson(dynamic json) {
    _revenueHeadName = json['revenue_head_name'];
    _calculated = json['calculated'];
    _amount = json['amount'];
    _vatAmount = json['vat_amount'];
    _totalBillAfterPenalty = json['total_bill_after_penalty'];
    _totalPayable = json['total_payable'];
  }
  String? _revenueHeadName;
  int? _calculated;
  dynamic? _amount;
  dynamic? _vatAmount;
  dynamic? _totalBillAfterPenalty;
  dynamic? _totalPayable;

  String? get revenueHeadName => _revenueHeadName;
  int? get calculated => _calculated;
  dynamic? get amount => _amount;
  dynamic? get vatAmount => _vatAmount;
  dynamic? get totalBillAfterPenalty => _totalBillAfterPenalty;
  dynamic? get totalPayable => _totalPayable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['revenue_head_name'] = _revenueHeadName;
    map['calculated'] = _calculated;
    map['amount'] = _amount;
    map['vat_amount'] = _vatAmount;
    map['total_bill_after_penalty'] = _totalBillAfterPenalty;
    map['total_payable'] = _totalPayable;
    return map;
  }

}