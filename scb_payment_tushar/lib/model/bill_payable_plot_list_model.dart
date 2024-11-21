/// id : 1822
/// cycle_id : 83
/// plot_no : "Plot No: 4"
/// plot_no_bn : "Plot No: 4"
/// road_no : "Rd N0: 07"
/// road_no_bn : "Rd N0: 07"
/// block_no : "N/A"
/// bill_cycle_name : "2022-23"
/// billing_name : "Holding Tax 2022-23"
/// total_amount : 4345

class BillPayablePlotListModel {
  BillPayablePlotListModel({
      int? id, 
      int? cycleId, 
      String? plotNo, 
      String? plotNoBn, 
      String? roadNo, 
      String? roadNoBn, 
      String? blockNo, 
      String? billCycleName, 
      String? billingName, 
      dynamic? totalAmount,
      dynamic? totalAmountShow,
  }){
    _id = id;
    _cycleId = cycleId;
    _plotNo = plotNo;
    _plotNoBn = plotNoBn;
    _roadNo = roadNo;
    _roadNoBn = roadNoBn;
    _blockNo = blockNo;
    _billCycleName = billCycleName;
    _billingName = billingName;
    _totalAmount = totalAmount;
    _totalAmountShow = totalAmountShow;
}

  BillPayablePlotListModel.fromJson(dynamic json) {
    _id = json['id'];
    _cycleId = json['cycle_id'];
    _plotNo = json['plot_no'];
    _plotNoBn = json['plot_no_bn'];
    _roadNo = json['road_no'];
    _roadNoBn = json['road_no_bn'];
    _blockNo = json['block_no'];
    _billCycleName = json['bill_cycle_name'];
    _billingName = json['billing_name'];
    _totalAmount = json['total_amount'];
    _totalAmountShow = json['total_amount_show'];
  }
  int? _id;
  int? _cycleId;
  String? _plotNo;
  String? _plotNoBn;
  String? _roadNo;
  String? _roadNoBn;
  String? _blockNo;
  String? _billCycleName;
  String? _billingName;
  dynamic? _totalAmount;
  dynamic? _totalAmountShow;

  int? get id => _id;
  int? get cycleId => _cycleId;
  String? get plotNo => _plotNo;
  String? get plotNoBn => _plotNoBn;
  String? get roadNo => _roadNo;
  String? get roadNoBn => _roadNoBn;
  String? get blockNo => _blockNo;
  String? get billCycleName => _billCycleName;
  String? get billingName => _billingName;
  dynamic? get totalAmount => _totalAmount;
  dynamic? get totalAmountShow => _totalAmountShow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cycle_id'] = _cycleId;
    map['plot_no'] = _plotNo;
    map['plot_no_bn'] = _plotNoBn;
    map['road_no'] = _roadNo;
    map['road_no_bn'] = _roadNoBn;
    map['block_no'] = _blockNo;
    map['bill_cycle_name'] = _billCycleName;
    map['billing_name'] = _billingName;
    map['total_amount'] = _totalAmount;
    map['totalAmountShow'] = _totalAmountShow;
    return map;
  }

}