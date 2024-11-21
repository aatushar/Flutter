/// rs_id : 2
/// bd_id : 1
/// pm_id : 4498
/// pc_id : 9645
/// ci_id : 90
/// be_name : "A/33"
/// bill_cycle_name : "Dec-22"
/// billing_name : "Monthly Board Rent & Service"
/// invoice_no : "INV-1673353595"
/// order_id : "SSF63bd597bed831"
/// be_id : 36
/// pay_user_id : 1527
/// currency : "BDT"
/// total_amount : "2,796.75"
/// payment_type : "Online"
/// created_at : "06:26 PM 10-01-23"
/// item_row : [{"ci_id":90,"cycle_name":"Dec-22","be_id":36,"be_name":"A/33","total_amount":2796.75}]

class Payment_statement_model {
  Payment_statement_model({
    dynamic? rsId,
    dynamic? bdId,
    dynamic? pmId,
    dynamic? pcId,
    dynamic? ciId,
      String? beName, 
      String? billCycleName, 
      String? billingName, 
      String? invoiceNo,
    String? orderId,
    dynamic? beId,
    dynamic? payUserId,
      String? currency,
    dynamic? totalAmount,
      String? paymentType, 
      String? createdAt, 
      List<Item_row>? itemRow,}){
    _rsId = rsId;
    _bdId = bdId;
    _pmId = pmId;
    _pcId = pcId;
    _ciId = ciId;
    _beName = beName;
    _billCycleName = billCycleName;
    _billingName = billingName;
    _invoiceNo = invoiceNo;
    _orderId = orderId;
    _beId = beId;
    _payUserId = payUserId;
    _currency = currency;
    _totalAmount = totalAmount;
    _paymentType = paymentType;
    _createdAt = createdAt;
    _itemRow = itemRow;
}

  Payment_statement_model.fromJson(dynamic json) {
    _rsId = json['rs_id'];
    _bdId = json['bd_id'];
    _pmId = json['pm_id'];
    _pcId = json['pc_id'];
    _ciId = json['ci_id'];
    _beName = json['be_name'];
    _billCycleName = json['bill_cycle_name'];
    _billingName = json['billing_name'];
    _invoiceNo = json['invoice_no'];
    _orderId = json['order_id'];
    _beId = json['be_id'];
    _payUserId = json['pay_user_id'];
    _currency = json['currency'];
    _totalAmount = json['total_amount'];
    _paymentType = json['payment_type'];
    _createdAt = json['created_at'];
    if (json['item_row'] != null) {
      _itemRow = [];
      json['item_row'].forEach((v) {
        _itemRow?.add(Item_row.fromJson(v));
      });
    }
  }
  dynamic? _rsId;
  dynamic? _bdId;
  dynamic? _pmId;
  dynamic? _pcId;
  dynamic? _ciId;
  String? _beName;
  String? _billCycleName;
  String? _billingName;
  String? _invoiceNo;
  String? _orderId;
  dynamic? _beId;
  dynamic? _payUserId;
  String? _currency;
  dynamic? _totalAmount;
  String? _paymentType;
  String? _createdAt;
  List<Item_row>? _itemRow;

  dynamic? get rsId => _rsId;
  dynamic? get bdId => _bdId;
  dynamic? get pmId => _pmId;
  dynamic? get pcId => _pcId;
  dynamic? get ciId => _ciId;
  String? get beName => _beName;
  String? get billCycleName => _billCycleName;
  String? get billingName => _billingName;
  String? get invoiceNo => _invoiceNo;
  String? get orderId => _orderId;
  dynamic? get beId => _beId;
  dynamic? get payUserId => _payUserId;
  String? get currency => _currency;
  dynamic? get totalAmount => _totalAmount;
  String? get paymentType => _paymentType;
  String? get createdAt => _createdAt;
  List<Item_row>? get itemRow => _itemRow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rs_id'] = _rsId;
    map['bd_id'] = _bdId;
    map['pm_id'] = _pmId;
    map['pc_id'] = _pcId;
    map['ci_id'] = _ciId;
    map['be_name'] = _beName;
    map['bill_cycle_name'] = _billCycleName;
    map['billing_name'] = _billingName;
    map['invoice_no'] = _invoiceNo;
    map['order_id'] = _orderId;
    map['be_id'] = _beId;
    map['pay_user_id'] = _payUserId;
    map['currency'] = _currency;
    map['total_amount'] = _totalAmount;
    map['payment_type'] = _paymentType;
    map['created_at'] = _createdAt;
    if (_itemRow != null) {
      map['item_row'] = _itemRow?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ci_id : 90
/// cycle_name : "Dec-22"
/// be_id : 36
/// be_name : "A/33"
/// total_amount : 2796.75

class Item_row {
  Item_row({
    dynamic? ciId,
      String? cycleName,
    dynamic? beId,
      String? beName,
    dynamic? totalAmount,}){
    _ciId = ciId;
    _cycleName = cycleName;
    _beId = beId;
    _beName = beName;
    _totalAmount = totalAmount;
}

  Item_row.fromJson(dynamic json) {
    _ciId = json['ci_id'];
    _cycleName = json['cycle_name'];
    _beId = json['be_id'];
    _beName = json['be_name'];
    _totalAmount = json['total_amount'];
  }
  dynamic? _ciId;
  String? _cycleName;
  dynamic? _beId;
  String? _beName;
  dynamic? _totalAmount;

  dynamic? get ciId => _ciId;
  String? get cycleName => _cycleName;
  dynamic? get beId => _beId;
  String? get beName => _beName;
  dynamic? get totalAmount => _totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ci_id'] = _ciId;
    map['cycle_name'] = _cycleName;
    map['be_id'] = _beId;
    map['be_name'] = _beName;
    map['total_amount'] = _totalAmount;
    return map;
  }

}