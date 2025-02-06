import 'dart:async';
import 'package:complaint_management/screen/bill/payment_gateway.dart';
import 'package:complaint_management/screen/bill/plot_bill_page.dart';
import 'package:complaint_management/screen/bill/shop_bill_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import '../../config/palette.dart';
import '../../model/bill_payable_plot_list_model.dart';
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


class PayableBillList extends StatefulWidget {
  @override
  State<PayableBillList> createState() => _PayableBillListState();
}

class _PayableBillListState extends State<PayableBillList> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<PayableBillModel> RouteList = [];
  List<RevenueSorceModel> RevSourceList = [];
  List<RevenueSourceHead> RevSourceHeadList = [];
  List<BillingDepartmentModel> BillingDepartmentList = [];
  List<BillPayablePlotListModel> PlotList = [];
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
      setState((){});
    });
  }
  TextEditingController  monthController = TextEditingController();
  TextEditingController  _AmountController = TextEditingController();

  int selectedBillingDept = 0;
  int selectedRevSource = 0;
  var billDeptID = null;
  var revResouceID = null;
  var curDeptID = 4;
  var curRevSrcID;
  var curBillName = 'All';
  int initStatus = 1;
  bool isDataFetch = true;
  dynamic revSourceID;
  dynamic LoginID;
  var userImgs;
  var userID;
  bool isPlotWiseList = true;


  SyncRevHead() async {
    dynamic revSourceid = await SessionManager().get("_revSource");
    dynamic Loginid = await SessionManager().get("LoginID");
    var userImgsTemp = await SessionManager().get("userImgs");
    // GetShopList();
    setState(() {
      fatchData = 'filter';
      revSourceID = revSourceid;
      curRevSrcID = revSourceid;
      LoginID = Loginid;
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    });
    setState(() {});
  }

  Future<List<ShopListModel>> GetShopList() async {
    dynamic userID = await SessionManager().get("id");
    var response = await http.get(Uri.parse('http://165.232.154.198/ccb/api/shop-info-list?RevSourceID=$curRevSrcID&billDeptID=$curDeptID&userID=$LoginID&isPlotWise=$isPlotWiseList'));
    var data = jsonDecode(response.body.toString());
      ShopList = [];
      if(response.statusCode == 200){
        for(Map i in data){
          ShopList.add(ShopListModel.fromJson(i));
        }
        if(isDataFetch){
          setState(() {
            ShopList;
          });
          isDataFetch = false;
        }
        return ShopList;
      }else{
        return ShopList;
      }
  }

  Future<List<BillPayablePlotListModel>> GetPlotList() async {
    dynamic userID = await SessionManager().get("id");
    var response = await http.get(Uri.parse('http://165.232.154.198/ccb/api/shop-info-list?RevSourceID=$curRevSrcID&billDeptID=$curDeptID&userID=$LoginID&isPlotWise=$isPlotWiseList'));
    var data = jsonDecode(response.body.toString());
    PlotList = [];
    if(response.statusCode == 200){
      for(Map i in data){
        PlotList.add(BillPayablePlotListModel.fromJson(i));
      }
      if(isDataFetch){
        setState(() {
          PlotList;
        });
        isDataFetch = false;
      }
      return PlotList;
    }else{
      return PlotList;
    }
  }


  PayableBillListFunc(id) async{
    final resData = await Navigator.push(context,MaterialPageRoute(builder: (context)=> new ShopBillPage(shopID:id,bdID:curDeptID.toString(),rsID:curRevSrcID.toString(), billName:curBillName,)));
  }
  PlotPayableBillListFunc(plot,cycle,billName) async{
    final resData = await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PlotBillPage(plotID:plot,cycleID:cycle,billName:billName,bdID:curDeptID.toString(),rsID:curRevSrcID.toString())));
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
      userID = await SessionManager().get("userID");
      Response response = await post(
          Uri.parse('http://165.232.154.198/ccb/api/payment-request'),
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
            SizedBox(height: 10),
            Text('Billing Department ',style:TextStyle(fontSize: 16.0,color: Palette.textClrGray)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:0,horizontal: 10),
              child: Container(
                // height: 100,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (revSourceID == 1) ?  InkWell(
                        onTap: (){
                          GetShopList();
                          setState(() { curDeptID = 4; curRevSrcID = revSourceID;curBillName = 'Holding TAX';isPlotWiseList = true;});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 4) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 4) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/holding-tax.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('TAX',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                      (revSourceID == 1) ? SizedBox(width: 12.5) : SizedBox(width: 0),
                      (revSourceID == 1) ? InkWell(
                        onTap: (){
                          GetShopList();
                          setState(() { curDeptID = 3;curRevSrcID = revSourceID;curBillName = 'Water';isPlotWiseList = true;});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 3) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 3) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/water.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Water',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                      (revSourceID == 1) ? SizedBox(width: 12.5) : SizedBox(width: 0),
                      (revSourceID == 1) ? InkWell(
                        onTap: (){
                          GetShopList();
                          setState(() { curDeptID = 5;curRevSrcID = 3;curBillName = 'Service';isPlotWiseList = false;});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 5) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                         boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 5) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/service.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Service',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                      (revSourceID == 1) ? SizedBox(width: 12.5) : SizedBox(width: 0),
                      (revSourceID == 1) ? InkWell(
                        onTap: (){
                          GetShopList();
                          setState(() { curDeptID = 6;curRevSrcID = revSourceID;curBillName = 'Dish';isPlotWiseList = false;});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 6) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 6) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/dish.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Dish',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                      (revSourceID == 1) ? SizedBox(width: 15) : SizedBox(width: 0),
                      (revSourceID == 2) ? InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShopBillPage(shopID:LoginID.toString(),rsID:'2',bdID:'1',billName:'Service')),
                          );
                          setState((){});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 1) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 1) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/service.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Service',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                      (revSourceID == 2) ? SizedBox(width: 15) : SizedBox(width: 0),
                      (revSourceID == 2) ? InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShopBillPage(shopID:LoginID.toString(),rsID:'2',bdID:'2',billName:'Electricity')),
                          );
                          setState((){});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 2) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 2) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/electricity.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Electricity',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                    ],
                  ),
                  SizedBox(height: 12.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (revSourceID == 1) ?  InkWell(
                        onTap: (){
                          GetShopList();
                          setState(() { curDeptID = 8;curRevSrcID = revSourceID;curBillName = 'Internet';isPlotWiseList = false;});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 8) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 8) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/internet.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Internet',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),
                      (revSourceID == 1) ? SizedBox(width: 12.5) : SizedBox(width: 0),
                      (revSourceID == 1) ? InkWell(
                        onTap: (){
                          GetShopList();
                          setState(() { curDeptID = 9;curRevSrcID = revSourceID;curBillName = 'Mosque';isPlotWiseList = false;});
                        },
                        child: new Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 75,
                                      width: 82,
                                      padding: EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        border:(curDeptID == 9) ? Border.all(color: Palette.primaryBG.withAlpha(200)) : Border.all(color: Palette.primaryBG.withAlpha(0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (curDeptID == 9) ? Palette.Shadow50 : Palette.Shadow20,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage('images/icons/new/mosque.png'),
                                                        fit: BoxFit.cover
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text('Mosque',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ),
                      ) : Text(''),

                    ],
                  )
                ],),

              ),
            ),
            SizedBox(height: 20),

            (revSourceID == 1) ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child:Text('Payable Bill Detail:',style:TextStyle(fontSize: 16.0,color: Palette.textClrGray)),
                ),
                (curDeptID == 4 || curDeptID == 3) ? Expanded(
                    child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)
                                ),
                                color: (isPlotWiseList == true) ? Palette.pbgSelected : Palette.backgroundColor,
                              ),
                              height: 30,
                              child: Center(
                                child: Text('Plots List'),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                isPlotWiseList = true;
                              });
                              GetShopList();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                ),
                                color: (isPlotWiseList == false) ? Palette.pbgSelected : Palette.backgroundColor,
                              ),
                              height: 30,
                              child: Center(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('Flats List'),
                                ),
                              ),
                            ),
                            onTap: (){
                              // print('Flats List');
                              // setState(() {
                              //   isPlotWiseList = false;
                              // });
                              // GetShopList();
                            },
                          ),
                        ),
                      ],
                    ),
                ) : Text(''),
              ],
            ) : Text(''),

            (revSourceID == 1) ? Expanded(
                child: (isPlotWiseList) ? FutureBuilder(
                    future: GetPlotList(),
                    builder: (context,snapshort) {
                      if (!snapshort.hasData) {
                        return Center( child: Text('Loading...', style: TextStyle(
                            color: Colors.black12,
                            fontSize: 18)
                        ));
                      }
                      else if (PlotList.length < 1) {
                        return Center( child: Text('No Data Found', style: TextStyle(
                            color: Colors.black12,
                            fontSize: 18)
                        ));
                      }
                      else{
                        return ListView.builder(
                            itemCount: PlotList.length,
                            itemBuilder: (context, index){
                              return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    side: BorderSide(
                                      color: Palette.primaryBG.withAlpha(100),
                                      width: 1.0,
                                    ),
                                  ),
                                  color: Colors.white,
                                  child:ListTile(
                                    leading: Image.asset(
                                      'images/icons/new/plot.png',
                                      height: 40.0,
                                      width: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                    title:Text(
                                      PlotList[index].billingName.toString()+' ('+PlotList[index].billCycleName.toString()+')',
                                      style: TextStyle(
                                          color: Palette.textClrDark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(PlotList[index].plotNo.toString()),
                                    trailing: Text(PlotList[index].totalAmountShow.toString()+'/-'),
                                    onTap: (){
                                      var billName = PlotList[index].billingName.toString()+' ('+PlotList[index].billCycleName.toString()+')';
                                      PlotPayableBillListFunc(PlotList[index].id.toString(),PlotList[index].cycleId.toString(),billName.toString());
                                      setState(() {});
                                    },
                                  )
                              );
                            }
                        );
                      }
                    }
                ) : FutureBuilder(
                    future: GetShopList(),
                    builder: (context,snapshort) {
                      if (!snapshort.hasData) {
                        return Center( child: Text('Loading...', style: TextStyle(
                            color: Colors.black12,
                            fontSize: 18)
                        ));
                      }
                      else if (ShopList.length < 1) {
                        return Center( child: Text('No Data Found', style: TextStyle(
                            color: Colors.black12,
                            fontSize: 18)
                        ));
                      }
                      else{
                        return ListView.builder(
                            itemCount: ShopList.length,
                            itemBuilder: (context, index){
                              return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    side: BorderSide(
                                      color: Palette.primaryBG.withAlpha(100),
                                      width: 1.0,
                                    ),
                                  ),
                                  color: Colors.white,
                                  child:ListTile(
                                    leading: Icon(
                                      Icons.home,
                                      size: 40.0,
                                      color: Palette.primaryBG,
                                    ),
                                    title:Text(
                                      ShopList[index].shopNewNum.toString(),
                                      style: TextStyle(
                                          color: Palette.textClrDark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text('Road No: '+ShopList[index].shopName.toString()),
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
                )
            ) : Text(''),
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
        backgroundColor: Palette.transBG,
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

    print('curRevSource '+curRevSrcID.toString());

    dynamic userID = await SessionManager().get("userID");
    var response = await http.get(Uri.parse("http://165.232.154.198/ccb/api/payable-bill-list?revSourceID=$curRevSrcID&revSourceHeadID=$revSourceHeadID&userID=$userID&fatchData=$fatchData&fatchSourceHead=$fatchSourceHead"));
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
