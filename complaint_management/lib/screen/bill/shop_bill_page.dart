import 'dart:convert';

import 'package:complaint_management/screen/bill/paybale_bill_list.dart';
import 'package:complaint_management/screen/bill/payment_gateway.dart';
import 'package:complaint_management/screen/bill/payment_response.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';
import '../../model/be_monthly_head_wise_payable_bill_model.dart';
import '../../config/palette.dart';
import '../complain_list.dart';
import '../home.dart';
import '../notification_list.dart';
import 'history.dart';


class ShopBillPage extends StatefulWidget {
  final String shopID;
  final String rsID;
  final String bdID;
  final String billName;
  const ShopBillPage({super.key, required this.shopID, required this.rsID, required this.bdID,required this.billName});
  @override
  State<ShopBillPage> createState() => _ShopBillPageState(shopID,bdID,rsID,billName);
}

class _ShopBillPageState extends State<ShopBillPage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final String shopID;
  final String bdID;
  final String rsID;
  final String billName;
  dynamic UserTableID;
  dynamic userID;
  dynamic userName;
  dynamic address;
  dynamic Email;
  dynamic MobileNo;
  dynamic _revSource;
  dynamic LoginID;
  dynamic LoginUser;
  dynamic City;

  var resData;
  var chrgPer = 2.5;
  var isPaymentFinish = false;
  _ShopBillPageState(this.shopID,this.bdID,this.rsID,this.billName);
  @override
  void initState() {
    GetUserID();
    resetCart();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    EasyLoading.show(status: 'loading...');
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      EasyLoading.dismiss();
    });
    GetBarChartData();
  }

  resetCart() async {
    userID = await SessionManager().get("userID");
    print('reseted $userID - $bdID');
    Response response = await post(
        Uri.parse('http://165.232.154.198/ccb/api/reset-to-cart'),
        body:{
          'billingDeptId':bdID.toString(),
          'userID':userID.toString(),
        }
    );
    GetBarChartData();
    var data = jsonDecode(response.body.toString());
    print(data);
  }

  var userImgs;
  dynamic totalBillAmount = 0.0;

  GetUserID() async {
    _revSource = await SessionManager().get("_revSource");
    userID = await SessionManager().get("userID");
    // print(userID);
    userName = await SessionManager().get("userName");
    LoginID = await SessionManager().get("LoginID");
    LoginUser = await SessionManager().get("LoginUser");
    MobileNo = await SessionManager().get("MobileNo");
    address = await SessionManager().get("address");
    Email = await SessionManager().get("Email");
    City = await SessionManager().get("City");
    var userImgsTemp = await SessionManager().get("userImgs");
    setState(() {
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
      _revSource = rsID;
    });
  }
  TextEditingController  monthController = TextEditingController();
  List<BeMonthlyHeadWisePayableBillModel> RouteList = [];
  String _PayUrl = '';
  bool isDataFatch = true;
  Future<List<BeMonthlyHeadWisePayableBillModel>> GetBarChartData() async {
    var response = await http.get(Uri.parse("http://165.232.154.198/ccb/api/payable-bill-list-v2?RevSourceID=$rsID&billDeptID=$bdID&shopID=$shopID&userID=$LoginID&cartID=$userID"));
    // resData = response.body.toString();
    // print('mm');
    var data = jsonDecode(response.body.toString());
    // print("http://165.232.154.198/ccb/api/payable-bill-list-v2?RevSourceID=$rsID&billDeptID=$bdID&shopID=$shopID&userID=$LoginID&cartID=$userID");
    setState(() {
      totalBillAmount = data['totalBillAmnt'];
    });
    RouteList = [];
    if(response.statusCode == 200){
      for(Map i in data['billList']){
        RouteList.add(BeMonthlyHeadWisePayableBillModel.fromJson(i));
      }
      if(isDataFatch){
        setState(() {
          RouteList;
          isDataFatch = false;
        });
      }
      return RouteList;
      EasyLoading.dismiss();
    }else{
      return RouteList;
    }
  }
  PayAllBill() async {
    Response response = await post(
        Uri.parse('http://165.232.154.198/ccb/api/all-payment-request'),
        body:{
          'data':resData,
        }
    );
    var data = jsonDecode(response.body.toString());

  }

  AddToCart (
      String billingDeptId,
      String billChildId,
      String amount,
      String isAdd) async {
    userID = await SessionManager().get("userID");
    // print(userID);
    Response response = await post(
        Uri.parse('http://165.232.154.198/ccb/api/add-to-cart-v2'),
        body:{
          'billingDeptId':billingDeptId.toString(),
          'billChildId':billChildId.toString(),
          'userID':userID.toString(),
          'isAdd':isAdd.toString(),
        }
    );
    print(response.body.toString());
    GetBarChartData();
  }




  ///--------------------------------------
  ///>>>>>>>>>>> SHURJO PAY SDK <<<<<<<<<<<<<<<<<<<<
  ShurjopayResponseModel shurjopayResponseModel = ShurjopayResponseModel();
  ShurjopayVerificationModel shurjopayVerificationModel = ShurjopayVerificationModel();

  PaySelectedBill() async {
    // String resURL = 'https://scb-bd.com/apis/shcc/api/get-check-payment-order-status?order_id=ATL66f8f0ab2d15f&invoice_no=INV-1727590565-12';
    // await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PayResponseStatusPage(payUrl:resURL,invoiceNo:'INV-1727590565-12')));
    userID = await SessionManager().get("userID");
    Response response = await post(
        Uri.parse('http://165.232.154.198/ccb/api/pay-selected-bill-request-v2'),
        body:{
          'billingDeptId':bdID.toString(),
          'totalBillAmount':totalBillAmount.toString(),
          'userID':userID.toString(),
          'userName':userName.toString(),
          'address': address.toString(),
          'Email': Email.toString(),
          'MobileNo': MobileNo.toString(),
        }
    );
    print(response.body.toString());
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      if(data['status']){
        // print(data);
        // await resetCart();
        await SP_SDK_INIT(data);
      }else{
        print('Failed to Payments');
      }
    }else{
      print('Failed to Payments');
    }
  }



  ShurjoPay shurjoPay = ShurjoPay();
  SP_SDK_INIT(data) async {
    print('init sp');
    ShurjopayConfigs shurjopayConfigs = ShurjopayConfigs(
      prefix: data['prefix'].toString(),
      userName: data['userName'].toString(),
      password: data['password'].toString(),
      clientIP: data['clientIP'].toString(),
    );

    ShurjopayRequestModel shurjopayRequestModel =
    ShurjopayRequestModel(
      configs: shurjopayConfigs,
      currency: data['currency'].toString(),
      amount: double.parse(data['totalAmount'].toString()),
      orderID: data['invoice'].toString(),
      discountAmount: double.parse(data['discountAmount'].toString()),
      discountPercentage: double.parse(data['discountPercentage'].toString()),
      customerName: data['custName'].toString(),
      customerPhoneNumber: data['custPhone'].toString(),
      customerAddress: data['custAddess'].toString(),
      customerCity: data['custCity'].toString(),
      customerPostcode: '1200',
      returnURL:data['returnUrl'].toString(),
      cancelURL:data['cancelUrl'].toString(),
    );
    print('init sp 1');
    shurjopayResponseModel = await shurjoPay.makePayment(
      context: context,
      shurjopayRequestModel: shurjopayRequestModel,
    );
    print('init sp 2');
    if(shurjopayResponseModel.status == true) {
      try {
        print('init sp 3');
        shurjopayVerificationModel =
        await shurjoPay.verifyPayment(
          orderID: shurjopayResponseModel.shurjopayOrderID!,
        );
        var resURL = data['returnUrl'].toString()+'?order_id='+shurjopayVerificationModel.orderId.toString()+'&invoice='+data['invoice'].toString();
        print(resURL);
        if (shurjopayVerificationModel.spCode == "1000") {
          print("Payment Varified");
        }
        if(shurjopayVerificationModel.spCode == "1068"){
          await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PayableBillList()));
        }else{
          await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PayResponseStatusPage(payUrl:resURL,invoiceNo:data['invoice'].toString())));
        }
      } catch (error) {
        print("root");
        print(error.toString());
      }
    }
  }





  void SendPaymentAPI(
      String billingDeptId,
      String billingName,
      String id,
      String billChildId,
      String billMonthId,
      String shopId,
      String Amount,
      String totalBillAmount,
      String penalty,
      String currency,
      String FlatNum,
      ) async {
    // print("mobile: "+MobileNo.toString());
    try{
      userID = await SessionManager().get("userID");
      Response response = await post(
          Uri.parse('http://165.232.154.198/ccb/api/payment-request'),
          body:{
            'billingDeptId':billingDeptId.toString(),
            'billName':billingName.toString(),
            'id':id.toString(),
            'billChildId':billChildId.toString(),
            'billMonthId':billMonthId.toString(),
            'shopId':shopId.toString(),
            'Amount':Amount.toString(),
            'totalBillAmount':totalBillAmount.toString(),
            'penalty':penalty.toString(),
            'currency':currency.toString(),
            'FlatNum':FlatNum.toString(),
            'userTableID':userID.toString(),
            'userID':MobileNo.toString(),
            'userName':userName.toString(),
            'address': address.toString(),
            'Email': Email.toString(),
            'MobileNo': MobileNo.toString(),
          }
      );
      // print(response.body.toString());
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        _PayUrl = data['pay_url'];
        if(data['status']){
          final resData = await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PayGetWayPage(payUrl:_PayUrl)));
        }else{
          print('Failed to Payments');
        }
      }else{
        print('Failed to Payments');
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  int _selectedIndex = 1;
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Palette.primaryBG;
  }

  Color getColorDisable(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Palette.textColor1;
  }

  @override
  Widget build(BuildContext context){
    var value;
    print(bdID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryBG,
        elevation: 0,
        // title: Text("Home - Online Payment"),
        leading: new IconButton(
            icon: new Icon( Icons.arrow_back_ios, color: Colors.white,  ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PayableBillList()),
              );
            }
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 5.0,bottom: 10.0,right: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  transformAlignment: Alignment.topRight,
                  child: FutureBuilder(
                      future: SessionManager().get("userName"),
                      builder: (context,snapshot){
                        return Text(snapshot.hasData ? snapshot.data.toString() : 'loading..',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 13));
                      }
                  ),
                ),
                Container(
                  transformAlignment: Alignment.topRight,
                  child: FutureBuilder(
                      future: SessionManager().get("LoginUser"),
                      builder: (context,snapshot){
                        return Text(snapshot.hasData ? snapshot.data.toString() : 'loading..',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 11));
                      }
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                image: DecorationImage(
                    image: NetworkImage("https://scb-bd.com/admin-login/public/ProfileImage/$userImgs"),
                    fit: BoxFit.cover
                ),
                // border: Border.all(
                //     color: Palette.primaryBGDark,
                //     width: 1.0
                // ),
              ),
            ),
          )
        ],
      ),
      body:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: FutureBuilder(
                    future: GetBarChartData(),
                    builder: (context,snapshort){
                      if(!snapshort.hasData){
                        return Center(
                          child: Text('Loading...',style: TextStyle(color:Colors.black12,fontSize: 20)),
                        );
                      }else{
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: RouteList.length,
                            itemBuilder: (context, index){
                              var childItemCounte = 0;
                              return (bdID == '4') ? Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: Palette.primaryBG10),
                                    bottom: BorderSide(width: 1.0, color: Palette.primaryBG10),
                                  ),
                                  color: (RouteList[index].isCheckChild == true) ? Palette.pbgSelected : Palette.primaryBGUnselect,
                                ),
                                child: ExpansionTile(
                                  // collapsedBackgroundColor:Colors.white,
                                  // backgroundColor:Palette.pbgSelected,
                                  leading: (RouteList[index].isCheck == true) ? Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value: RouteList[index].isCheckChild,
                                    onChanged: (bool? value) {
                                      var isAdd = false;
                                      if(RouteList[index].isCheckChild == true){
                                        isAdd = false;
                                      }else{
                                        isAdd = true;
                                      }
                                      setState(() {
                                        AddToCart(
                                          RouteList[index].billingDeptId.toString(),
                                          RouteList[index].billChildId.toString(),
                                          RouteList[index].amount.toString(),
                                          isAdd.toString(),
                                        );
                                      });
                                    },
                                  ) : Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColorDisable),
                                    value: RouteList[index].isCheckChild,
                                    onChanged: (bool? value) {
                                      var isAdd = false;
                                      setState(() {
                                        AddToCart(
                                          RouteList[index].billingDeptId.toString(),
                                          RouteList[index].billChildId.toString(),
                                          RouteList[index].amount.toString(),
                                          isAdd.toString(),
                                        );
                                      });
                                    },
                                  ),
                                  title: Text(
                                    RouteList[index].billingName.toString()+' - '+RouteList[index].billCycleName.toString(),
                                    style: TextStyle(
                                      color: Palette.textClrDark,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(RouteList[index].shopNewNum.toString(),style: TextStyle(color:Palette.textClrGray)),
                                  trailing: Text(RouteList[index].currency.toString()+' '+RouteList[index].amount.toString()+' /-',style: TextStyle(color:Palette.textClrDark,fontWeight: FontWeight.bold)),
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Discount Date: '),
                                                    Text(RouteList[index].discountDate.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(''),
                                                    Text(RouteList[index].weavedAmount.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black12,
                                              height: 5,
                                              thickness: 2,
                                              indent: 5,
                                              endIndent: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Penalty: '),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(''),
                                                    Text(RouteList[index].penalty.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black12,
                                              height: 5,
                                              thickness: 2,
                                              indent: 5,
                                              endIndent: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Due Date: '),
                                                    Text(RouteList[index].dueDate.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(''),
                                                    Text(RouteList[index].totalBillAmount.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,)
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ): (true) ? Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: Palette.primaryBG10),
                                    bottom: BorderSide(width: 1.0, color: Palette.primaryBG10),
                                  ),
                                  color: (RouteList[index].isCheckChild == true) ? Palette.pbgSelected : Palette.primaryBGUnselect,
                                ),
                                child: ExpansionTile(
                                  // collapsedBackgroundColor:Colors.white,
                                  // backgroundColor:Palette.pbgSelected,
                                  leading: (RouteList[index].isCheck == true) ? Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value: RouteList[index].isCheckChild,
                                    onChanged: (bool? value) {
                                      var isAdd = false;
                                      if(RouteList[index].isCheckChild == true){
                                        isAdd = false;
                                      }else{
                                        isAdd = true;
                                      }
                                      setState(() {
                                        AddToCart(
                                          RouteList[index].billingDeptId.toString(),
                                          RouteList[index].billChildId.toString(),
                                          RouteList[index].amount.toString(),
                                          isAdd.toString(),
                                        );
                                      });
                                    },
                                  ) : Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColorDisable),
                                    value: RouteList[index].isCheckChild,
                                    onChanged: (bool? value) {
                                      var isAdd = false;
                                      setState(() {
                                        AddToCart(
                                          RouteList[index].billingDeptId.toString(),
                                          RouteList[index].billChildId.toString(),
                                          RouteList[index].amount.toString(),
                                          isAdd.toString(),
                                        );
                                      });
                                    },
                                  ),
                                  title: Text(
                                    RouteList[index].billingName.toString()+' - '+RouteList[index].billCycleName.toString(),
                                    style: TextStyle(
                                      color: Palette.textClrDark,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(RouteList[index].shopNewNum.toString(),style: TextStyle(color:Palette.textClrGray)),
                                  trailing: Text(RouteList[index].currency.toString()+' '+RouteList[index].amount.toString()+' /-',style: TextStyle(color:Palette.textClrDark,fontWeight: FontWeight.bold)),
                                  children: <Widget>[
                                    ListView.builder(
                                        itemCount: RouteList[index].itemRow?.length.toInt(),
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int idx) {
                                          return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(RouteList[index].itemRow![idx].revenueHeadName.toString()+': '),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(''),
                                                          Text(RouteList[index].itemRow![idx].amount.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: Colors.black12,
                                                    height: 5,
                                                    thickness: 2,
                                                    indent: 5,
                                                    endIndent: 5,
                                                  ),
                                                ],
                                              )
                                          );
                                        }
                                    ),
                                    (RouteList[index].billingDeptId.toString() == '1') ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('VAT: '),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(''),
                                                    Text(RouteList[index].vatAmount.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black12,
                                              height: 5,
                                              thickness: 2,
                                              indent: 5,
                                              endIndent: 5,
                                            )
                                          ],
                                        )
                                    ) : SizedBox(),
                                    (RouteList[index].isPanalty == true) ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Penalty: '),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(''),
                                                    Text(RouteList[index].penalty.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black12,
                                              height: 5,
                                              thickness: 2,
                                              indent: 5,
                                              endIndent: 5,
                                            ),
                                          ],
                                        )
                                    ) : SizedBox(),
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Due Date: '),
                                                    Text(RouteList[index].dueDate.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(' '),
                                                    Text(RouteList[index].totalBillAmount.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5)
                                          ],
                                        )
                                    )

                                    // (RouteList[index].billingDeptId.toString() == '')
                                  ],
                                ),
                              ) : Card(
                                  color: (RouteList[index].isCheckChild == true) ? Palette.pbgSelected : Colors.white ,
                                  child:ListTile(
                                    focusColor: Palette.primaryBG,
                                    leading: (RouteList[index].isCheck == true) ? Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                      value: RouteList[index].isCheckChild,
                                      onChanged: (bool? value) {
                                        var isAdd = false;
                                        if(RouteList[index].isCheckChild == true){
                                          isAdd = false;
                                        }else{
                                          isAdd = true;
                                        }
                                        setState(() {
                                          AddToCart(
                                            RouteList[index].billingDeptId.toString(),
                                            RouteList[index].billChildId.toString(),
                                            RouteList[index].amount.toString(),
                                            isAdd.toString(),
                                          );
                                        });
                                      },
                                    ) : Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.resolveWith(getColorDisable),
                                      value: RouteList[index].isCheckChild,
                                      onChanged: (bool? value) {
                                        var isAdd = false;
                                        setState(() {
                                          AddToCart(
                                            RouteList[index].billingDeptId.toString(),
                                            RouteList[index].billChildId.toString(),
                                            RouteList[index].amount.toString(),
                                            isAdd.toString(),
                                          );
                                        });
                                      },
                                    ),
                                    title:Text(
                                      RouteList[index].billingName.toString()+' - '+RouteList[index].billCycleName.toString(),
                                      style: TextStyle(
                                        color: Palette.textClrDark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(RouteList[index].shopNewNum.toString(),style: TextStyle(color:Palette.textClrGray)),
                                    trailing: Text(RouteList[index].currency.toString()+' '+RouteList[index].amount.toString()+' /-',style: TextStyle(color:Palette.textClrDark,fontWeight: FontWeight.bold)),
                                    onTap:(){
                                      // SendPaymentAPI(
                                      //   RouteList[index].billingDeptId.toString(),
                                      //   RouteList[index].billingName.toString()+'-'+RouteList[index].billCycleName.toString(),
                                      //   RouteList[index].billMasterId.toString(),
                                      //   RouteList[index].billChildId.toString(),
                                      //   RouteList[index].billCycleId.toString(),
                                      //   RouteList[index].shopId.toString(),
                                      //   RouteList[index].amount.toString(),
                                      //   RouteList[index].totalBillAmount.toString(),
                                      //   RouteList[index].penalty.toString(),
                                      //   RouteList[index].currency.toString(),
                                      //   RouteList[index].shopNewNum.toString(),
                                      // );
                                      // setState(() {});
                                    },
                                  )
                              );
                            }
                        );
                      }
                    }
                )
            ),
            (totalBillAmount != 0) ? Container(
              padding: EdgeInsets.symmetric(vertical: 0,horizontal:5.0 ),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox.fromSize(
                        size: Size(27, 27), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.red, // button color
                            child: InkWell(
                              splashColor: Colors.red, // splash color
                              onTap: () {
                                resetCart();
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.cleaning_services,color:Colors.white,size: 18,), // icon
                                  // Text("Call"), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width:10),
                      Text('Total: $totalBillAmount /-',style: TextStyle(
                        color: Palette.textClrDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ))
                    ],
                  ),
                  SizedBox(width:1),
                  (totalBillAmount != '0.00') ?  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Palette.primaryBG,
                      elevation: 7,  // Elevation
                      shadowColor: Palette.primaryBG, // Shadow Color
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      PaySelectedBill();
                    },
                  ) : SizedBox(width:50,height: 50),
                ],
              ),
            ) : Container(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.white,),
          Icon(Icons.notifications_on, size: 30,color: Colors.white),
          Image.asset(
            'images/icons/new/pay_icon.png',
            height: 45.0,
            width: 45.0,
            fit: BoxFit.cover,
          ),
          Icon(Icons.history, size: 30,color: Colors.white),
          Icon(Icons.thumb_down, size: 30,color: Colors.white),
        ],
        color: Palette.primaryBG,
        buttonBackgroundColor: Palette.primaryBG,
        backgroundColor: Palette.backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _page = index;
            setState(() async {
              if(_page == 0){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
              else if(_page == 1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );

              }
              else if(_page ==2){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayableBillList()),
                );
              }
              else if(_page ==3){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentHistory()),
                );
              }
              else if(_page ==4){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplainPage()),
                );
              }
            });
            print(index);
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

