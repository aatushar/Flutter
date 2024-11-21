/// rs_id : 2
/// bd_id : 1
/// pm_id : 177
/// pc_id : 501
/// ci_id : 82
/// bill_cycle_name : "Aug-22"
/// billing_name : "Monthly Service Charge- Aug-22"
/// invoice_no : "INV-1664779511"
/// order_id : "SSU633a841b05c1a"
/// be_id : 637
/// pay_user_id : 88
/// currency : "BDT"
/// total_amount : "1,510.75"
/// payment_type : "Online"
/// created_at : "06:45 AM 03-10-22"

class UserPaymentHistory {
  UserPaymentHistory({
    int? rsId,
    int? bdId,
    int? pmId,
    int? pcId,
    int? ciId,
    String? billCycleName,
    String? billingName,
    String? invoiceNo,
    String? orderId,
    int? beId,
    int? payUserId,
    String? currency,
    String? totalAmount,
    String? paymentType,
    String? createdAt,}){
    _rsId = rsId;
    _bdId = bdId;
    _pmId = pmId;
    _pcId = pcId;
    _ciId = ciId;
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
  }

  UserPaymentHistory.fromJson(dynamic json) {
    _rsId = json['rs_id'];
    _bdId = json['bd_id'];
    _pmId = json['pm_id'];
    _pcId = json['pc_id'];
    _ciId = json['ci_id'];
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
  }
  int? _rsId;
  int? _bdId;
  int? _pmId;
  int? _pcId;
  int? _ciId;
  String? _billCycleName;
  String? _billingName;
  String? _invoiceNo;
  String? _orderId;
  int? _beId;
  int? _payUserId;
  String? _currency;
  String? _totalAmount;
  String? _paymentType;
  String? _createdAt;

  int? get rsId => _rsId;
  int? get bdId => _bdId;
  int? get pmId => _pmId;
  int? get pcId => _pcId;
  int? get ciId => _ciId;
  String? get billCycleName => _billCycleName;
  String? get billingName => _billingName;
  String? get invoiceNo => _invoiceNo;
  String? get orderId => _orderId;
  int? get beId => _beId;
  int? get payUserId => _payUserId;
  String? get currency => _currency;
  String? get totalAmount => _totalAmount;
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
    map['invoice_no'] = _invoiceNo;
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