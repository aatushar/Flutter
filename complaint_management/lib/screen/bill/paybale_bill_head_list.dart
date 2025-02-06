import 'dart:async';

import 'package:complaint_management/screen/bill/paybale_bill_list.dart';
import 'package:complaint_management/screen/bill/payment_gateway.dart';
import 'package:complaint_management/screen/bill/shop_bill_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import '../../config/palette.dart';
import '../../model/billing_department_model.dart';
import '../../model/payable_bill_model.dart';
import '../../model/revenue_sorce_model.dart';
import '../../model/revenue_source_head.dart';
import '../../model/shop_list_model.dart';
import '../complain_create.dart';
import '../complain_list.dart';
import '../home.dart';
import '../notification_list.dart';
import 'history.dart';


class PayableBillHeadList extends StatefulWidget {
  @override
  State<PayableBillHeadList> createState() => _PayableBillHeadListState();
}

class _PayableBillHeadListState extends State<PayableBillHeadList> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<PayableBillModel> RouteList = [];
  List<RevenueSorceModel> RevSourceList = [];
  List<RevenueSourceHead> RevSourceHeadList = [];
  List<BillingDepartmentModel> BillingDepartmentList = [];
  List<ShopListModel> ShopList = [];

  String _PayMonth = '2021-Oct';
  bool _Amountvalidate = false;
  String _AmountErrMsg = '';
  String _PayUrl = '';
  String fatchData = 'all';
  @override
  void initState(){

    EasyLoading.show(status: 'loading...');
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    Timer(Duration(seconds: 1), () {
      SyncRevHead();
      print('dd');
      setState((){});
    });
  }
  TextEditingController  monthController = TextEditingController();
  TextEditingController  _AmountController = TextEditingController();

  int selectedBillingDept = 0;
  int selectedRevSource = 0;
  var billDeptID = null;
  var revResouceID = null;
  int initStatus = 1;

  SyncRevHead(){
    setState(() {
      fatchData = 'filter';
      if(RevSourceList.length > 0){
        revResouceID = RevSourceList[selectedRevSource].id.toString();
      }
      if(BillingDepartmentList.length > 0){
        billDeptID = BillingDepartmentList[selectedBillingDept].id.toString();
      }
    });
    setState(() {});
  }

  Future<List<RevenueSorceModel>> GetRevenueSourceList() async {
    dynamic userID = await SessionManager().get("id");
    var response = await http.get(Uri.parse("http://165.22.106.139/market_ms/public/api/revenue-source-list?userID=$userID"));
    var data = jsonDecode(response.body.toString());
    RevSourceList = [];
    if(response.statusCode == 200){
      for(Map i in data){
        RevSourceList.add(RevenueSorceModel.fromJson(i));
      }
      return RevSourceList;
    }else{
      return RevSourceList;
    }

  }

  Future<List<BillingDepartmentModel>> GetBillingDepartmentList() async {
    // print('dp');
    var id = '';
    if(RevSourceList.length > 0){
      id = RevSourceList[selectedRevSource].id.toString();
    }
    dynamic userID = await SessionManager().get("id");
    var response = await http.get(Uri.parse('http://165.22.106.139/market_ms/public/api/billing-department-list?RevSourceID=$id&userID=$userID'));
    var data = jsonDecode(response.body.toString());
    // print(data);
    BillingDepartmentList = [];
    if(response.statusCode == 200){
      for(Map i in data){
        BillingDepartmentList.add(BillingDepartmentModel.fromJson(i));
      }
      billDeptID = BillingDepartmentList[selectedBillingDept].id.toString();
      // print("init before: $initStatus");
      if(initStatus == 1){
        setState(() {});
        initStatus = 0;
      }
      // print("init: $initStatus");
      return BillingDepartmentList;
    }else{
      return BillingDepartmentList;
    }

  }

  Future<List<ShopListModel>> GetShopList() async {
    // print('sp');
    // print("res $revResouceID");
    // print("dept: $billDeptID");

    dynamic userID = await SessionManager().get("id");
    var response = await http.get(Uri.parse('http://165.22.106.139/market_ms/public/api/shop-info-list?RevSourceID=$revResouceID&billDeptID=$billDeptID&userID=$userID'));
    var data = jsonDecode(response.body.toString());
    // print(data);
    ShopList = [];
    if(response.statusCode == 200){
      for(Map i in data){
        ShopList.add(ShopListModel.fromJson(i));
      }
      return ShopList;
    }else{
      return ShopList;
    }

  }

  PayableBillListFunc(id) async {
    var bdID = null;
    var rsID = null;
    if(RevSourceList.length > 0){
      rsID = RevSourceList[selectedRevSource].id.toString();
    }
    if(BillingDepartmentList.length > 0){
      bdID = BillingDepartmentList[selectedBillingDept].id.toString();
    }
    final resData = await Navigator.push(context,MaterialPageRoute(builder: (context)=> new ShopBillPage(shopID:id,bdID:bdID,rsID:rsID, billName: '',)));
  }

  void SendPaymentAPI(
      String id,
      String billChildId,
      String billMonthId,
      String shopId,
      String revenueHeadId,
      String Amount,
      String currency,
      String ReveHead,
      String FlatNum,
      ) async{
    EasyLoading.show(status: 'loading...');

    try{
      Response response = await post(
          Uri.parse('http://165.22.106.139/market_ms/public/api/payment-request'),
          body:{
            'id':id,
            'billChildId':billChildId,
            'billMonthId':billMonthId,
            'shopId':shopId,
            'revenueHeadId':revenueHeadId,
            'Amount':Amount,
            'currency':currency,
            'ReveHead':ReveHead,
            'FlatNum':FlatNum,
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
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

  //// for button area
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    // GetSparkBarChartData();
    var value;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
        appBar: AppBar(
          backgroundColor: Palette.primaryBG,
          elevation: 1,
          titleSpacing: 0.0,
          // title: Text("Home - Online Payment"),
          leading: new IconButton(
              icon: new Icon( Icons.arrow_back_ios, color: Colors.white,  ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
          ),
          // title: Text("Home - Online Payment"),
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
                        future: SessionManager().get("userID"),
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
                      image: AssetImage('images/user/mostafa.jpeg'),
                      fit: BoxFit.cover
                  ),
                  // border: Border.all(
                  //     color: Palette.primaryBGDark,
                  //     width: 1.0
                  // ),
                ),
              ),
            ),
          ],
        ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 0.0,right: 5.0,left: 5.0,top: 5.0),
        decoration: BoxDecoration(
            color:Colors.white12,
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 2),
            Text('Revenue Source',style:TextStyle(fontSize: 16.0,color: Palette.textClrGray,fontWeight: FontWeight.bold)),
            Container(
              height: 80,
              child: FutureBuilder(
                  future: GetRevenueSourceList(),
                  builder: (context,snapshort){
                    if (!snapshort.hasData) {
                      return Text('', style: TextStyle(
                          color: Palette.primaryBG, fontSize: 25));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: RevSourceList.length,
                        itemBuilder: (BuildContext context, int position) {
                          return InkWell(
                            onTap: () {
                              setState(() => selectedRevSource = position);
                              SyncRevHead();
                              print(position);
                            },
                            child: Container(
                              width: 110,
                              child:Card(
                                  color: (selectedRevSource==position) ? Palette.primaryBG : null,
                                  elevation: 1,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                    side: BorderSide(
                                      color: (selectedRevSource==position) ? Palette.primaryBG : Palette.primaryBG10,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.wallet_membership,color:(selectedRevSource==position) ? Palette.textClr : Palette.textClrGray),
                                        SizedBox(height: 2.0,),
                                        Text(RevSourceList[position].revenueSourceName.toString(),style: TextStyle(color: (selectedRevSource==position) ? Palette.textClr : Palette.textClrDark)),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),

            ),

            SizedBox(height: 10),
            Text('Billing Department',style:TextStyle(fontSize: 16.0,color: Palette.textClrGray,fontWeight: FontWeight.bold)),
            Container(
              height: 70,
              child: FutureBuilder(
                  future: GetBillingDepartmentList(),
                  builder: (context,snapshort){
                    if (!snapshort.hasData) {
                      return Text('', style: TextStyle(
                          color: Palette.primaryBG, fontSize: 25));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BillingDepartmentList.length,
                        itemBuilder: (BuildContext context, int position) {
                          return InkWell(
                            onTap: () {
                              setState(() => selectedBillingDept = position);
                              SyncRevHead();
                              print(position);
                            },
                            child: Container(
                              width: 150,
                              child:Card(
                                  color: (selectedBillingDept==position) ? Palette.primaryBG : null,
                                  elevation: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.wallet_membership,color:(selectedBillingDept==position) ? Palette.textClr : Palette.textClrGray),
                                        SizedBox(height: 2.0,),
                                        Text(BillingDepartmentList[position].billingDeptName.toString(),style: TextStyle(color: (selectedBillingDept==position) ? Palette.textClr : Palette.textClrDark)),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),

            ),
            SizedBox(height: 10),
            Text('Shop List',style:TextStyle(fontSize: 16.0,color: Palette.textClrGray,fontWeight: FontWeight.bold)),
            Expanded(child: FutureBuilder(
                future: GetShopList(),
                builder: (context,snapshort){
                  if(!snapshort.hasData){
                    return Text('',style: TextStyle(color:Palette.primaryBG,fontSize: 25));
                  }else{
                    return ListView.builder(
                        itemCount: ShopList.length,
                        itemBuilder: (context, index){
                          return Card(
                              child:ListTile(
                                leading: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 50.0,
                                  color: Palette.primaryBG,
                                ),
                                title:Text(
                                  ShopList[index].shopNewNum.toString(),
                                  style: TextStyle(
                                    color: Palette.textClrDark,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle: Text(ShopList[index].shopName.toString()+' - '+ShopList[index].shopTypeName.toString()),
                                // trailing: Icons.payment,
                                onTap: (){
                                  PayableBillListFunc(ShopList[index].id.toString());
                                  setState(() {});
                                },
                              )
                          );
                        }
                    );
                  }
                }
            ))
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
        backgroundColor: Colors.white,
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



  Future<List<PayableBillModel>> GetBarChartData() async {
    var revSourceHeadID = null;
    var revSourceID = null;
    if(RevSourceList.length > 0){
      revSourceID = RevSourceList[selectedRevSource].id;
    }else{
      fatchData = 'all';
    }
    var fatchSourceHead = 'all';
    if(selectedBillingDept != -1) {
      revSourceHeadID = RevSourceHeadList[selectedBillingDept].id;
      fatchSourceHead = 'filter';
    }

    dynamic userID = await SessionManager().get("userID");
    var response = await http.get(Uri.parse("http://165.22.106.139/market_ms/public/api/payable-bill-list?revSourceID=$revSourceID&revSourceHeadID=$revSourceHeadID&userID=$userID&fatchData=$fatchData&fatchSourceHead=$fatchSourceHead"));
    var data = jsonDecode(response.body.toString());
    RouteList = [];
    if(response.statusCode == 200){
      for(Map i in data){
        RouteList.add(PayableBillModel.fromJson(i));
      }
      return RouteList;
      EasyLoading.dismiss();
    }else{
      return RouteList;
    }

  }


}
