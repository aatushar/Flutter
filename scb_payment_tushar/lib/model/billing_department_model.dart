/// id : 1
/// billing_dept_name : "General Service"
/// billing_dept_name_bn : "General Service"

class BillingDepartmentModel {
  BillingDepartmentModel({
      int? id, 
      String? billingDeptName, 
      String? billingDeptNameBn,}){
    _id = id;
    _billingDeptName = billingDeptName;
    _billingDeptNameBn = billingDeptNameBn;
}

  BillingDepartmentModel.fromJson(dynamic json) {
    _id = json['id'];
    _billingDeptName = json['billing_dept_name'];
    _billingDeptNameBn = json['billing_dept_name_bn'];
  }
  int? _id;
  String? _billingDeptName;
  String? _billingDeptNameBn;

  int? get id => _id;
  String? get billingDeptName => _billingDeptName;
  String? get billingDeptNameBn => _billingDeptNameBn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['billing_dept_name'] = _billingDeptName;
    map['billing_dept_name_bn'] = _billingDeptNameBn;
    return map;
  }

}