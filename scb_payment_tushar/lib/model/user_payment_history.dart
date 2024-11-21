/// rs_id : 2
/// bd_id : 2
/// pm_id : 24
/// pc_id : 26
/// ci_id : 2
/// bill_cycle_name : "May-22"
/// billing_name : "Elect Bill-Common [May-22]"
/// order_id : "ATL62bc279e67aa3"
/// be_id : 17
/// pay_user_id : 1520
/// currency : "BDT"
/// total_amount : 4.09
/// payment_type : "Online"

class UserPaymentHistory {
  UserPaymentHistory({
      int? rsId, 
      int? bdId, 
      int? pmId, 
      int? pcId, 
      int? ciId, 
      String? billCycleName, 
      String? billingName, 
      String? orderId,
      int? beId,
      int? payUserId, 
      String? currency, 
      double? totalAmount, 
      String? paymentType,
      String? createdAt}){
    _rsId = rsId;
    _bdId = bdId;
    _pmId = pmId;
    _pcId = pcId;
    _ciId = ciId;
    _billCycleName = billCycleName;
    _billingName = billingName;
    _orderId = orderId;
    _beId = beId;
    _payUserId = payUserId;
    _currency = currency;
    _totalAmount = totalAmount;
    _paymentType = paymentType;
    _createdAt = createdAt;
}

  UserPaymentHistory.fromJson(dynamic json) {
    _rsId = json['rs_id'];
    _bdId = json['bd_id'];
    _pmId = json['pm_id'];
    _pcId = json['pc_id'];
    _ciId = json['ci_id'];
    _billCycleName = json['bill_cycle_name'];
    _billingName = json['billing_name'];
    _orderId = json['order_id'];
    _beId = json['be_id'];
    _payUserId = json['pay_user_id'];
    _currency = json['currency'];
    _totalAmount = json['total_amount'];
    _paymentType = json['payment_type'];
    _createdAt = json['created_at'];
  }
  int? _rsId;
  int? _bdId;
  int? _pmId;
  int? _pcId;
  int? _ciId;
  String? _billCycleName;
  String? _billingName;
  String? _orderId;
  int? _beId;
  int? _payUserId;
  String? _currency;
  double? _totalAmount;
  String? _paymentType;
  String? _createdAt;

  int? get rsId => _rsId;
  int? get bdId => _bdId;
  int? get pmId => _pmId;
  int? get pcId => _pcId;
  int? get ciId => _ciId;
  String? get billCycleName => _billCycleName;
  String? get billingName => _billingName;
  String? get orderId => _orderId;
  int? get beId => _beId;
  int? get payUserId => _payUserId;
  String? get currency => _currency;
  double? get totalAmount => _totalAmount;
  String? get paymentType => _paymentType;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rs_id'] = _rsId;
    map['bd_id'] = _bdId;
    map['pm_id'] = _pmId;
    map['pc_id'] = _pcId;
    map['ci_id'] = _ciId;
    map['bill_cycle_name'] = _billCycleName;
    map['billing_name'] = _billingName;
    map['order_id'] = _orderId;
    map['be_id'] = _beId;
    map['pay_user_id'] = _payUserId;
    map['currency'] = _currency;
    map['total_amount'] = _totalAmount;
    map['payment_type'] = _paymentType;
    map['created_at'] = _createdAt;
    return map;
  }

}