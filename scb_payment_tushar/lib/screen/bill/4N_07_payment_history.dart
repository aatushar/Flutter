import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_paybale_bill_list.dart';
import 'package:scb_payment_tushar/screen/bill/4N_07_A_previous_bill_list_screen.dart';
import 'package:scb_payment_tushar/screen/bill/payment_gateway.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/palette.dart';
import '../../model/user_payment_history.dart';
import '../../model/user_payment_history_model.dart';
import '../complain_create.dart';
import '../complain_list.dart';
import '../home.dart';
import '../notification_list.dart';
// Import the screen

class PaymentHistory extends StatefulWidget {
  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<UserPaymentHistoryModel> PaymentHistoryList = [];

  String _PayMonth = '2021-Oct';
  bool _Amountvalidate = false;
  String _AmountErrMsg = '';
  String _PayUrl = '';
  String fatchData = 'all';

  @override
  void initState() {
    getInitFunc();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }
  var userImgs;
  getInitFunc() async {
    var userImgsTemp = await SessionManager().get("userImgs");
    setState(() {
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    });
  }

  TextEditingController  monthController = TextEditingController();
  TextEditingController  _AmountController = TextEditingController();

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
      ) async {

    try{
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
        setState(() {});
      }else{
        print('Failed to Payments');
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  int selectedRevSourceHead = -1;
  int selectedRevSource = -1;

  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryBG,
        elevation: 1,
        titleSpacing: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, bottom: 10.0, right: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  transformAlignment: Alignment.topRight,
                  child: FutureBuilder(
                    future: SessionManager().get("userName"),
                    builder: (context, snapshot) {
                      return Text(snapshot.hasData ? snapshot.data.toString() : 'loading..',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13));
                    },
                  ),
                ),
                Container(
                  transformAlignment: Alignment.topRight,
                  child: FutureBuilder(
                    future: SessionManager().get("LoginUser"),
                    builder: (context, snapshot) {
                      return Text(snapshot.hasData ? snapshot.data.toString() : 'loading..',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11));
                    },
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
                  image: AssetImage("assets/images/user/mostafa2.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 0.0, right: 5.0, left: 5.0, top: 5.0),
        decoration: BoxDecoration(
          color: Colors.white12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text('Payment History', style: TextStyle(fontSize: 16.0, color: Palette.textClrGray, fontWeight: FontWeight.bold)),
            Expanded(
              child: FutureBuilder(
                future: GetPaymentHistoryData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading...', style: TextStyle(color: Palette.textClrGray, fontSize: 18)));
                  } else if (PaymentHistoryList.length < 1) {
                    return Center(child: Text('No Data Found', style: TextStyle(color: Palette.textClrGray, fontSize: 18)));
                  } else {
                    return ListView.builder(
                      itemCount: PaymentHistoryList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ExpansionTile(
                            leading: Image.asset(
                              'assets/images/icons/new/pdf-file.png',
                              height: 40.0,
                              width: 40.0,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              PaymentHistoryList[index].billingName.toString(),
                              style: TextStyle(color: Palette.textClrDark, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              '${PaymentHistoryList[index].currency.toString()} ${PaymentHistoryList[index].totalAmount.toString()}/-',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Divider(height: 1),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Pay Date: '),
                                            Text(PaymentHistoryList[index].createdAt.toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('${PaymentHistoryList[index].totalAmount.toString()}/-'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('See more: ', style: TextStyle(color: Palette.textClrDark, decoration: TextDecoration.underline)),
                                            InkWell(
                                              child: Text('Download', style: TextStyle(color: Palette.primaryBG, decoration: TextDecoration.underline, fontSize: 18)),
                                              onTap: () {
                                                setState(() {
                                                  _getInvoicePDF(PaymentHistoryList[index].invoiceNo.toString());
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 35),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreviousBillListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                'Previous Bill List',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 3,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.notifications_on, size: 30, color: Colors.white),
              Image.asset(
                'assets/images/icons/new/pay_icon.png',
                height: 45.0,
                width: 45.0,
                fit: BoxFit.cover,
              ),
              Icon(Icons.history, size: 30, color: Colors.white),
              Icon(Icons.arrow_right, size: 60, color: Colors.white),
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
                  if (_page == 0) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  } else if (_page == 1) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                  } else if (_page == 2) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PayableBillList()));
                  } else if (_page == 3) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentHistory()));
                  } else if (_page == 4) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousBillListScreen()));
                  }
                });
              });
            },
            letIndexChange: (index) => true,
          ),
        ],
      ),
    );
  }

  Future<List<UserPaymentHistoryModel>> GetPaymentHistoryData() async {
    EasyLoading.show(status: 'loading...');
    dynamic LoginID = await SessionManager().get("LoginID");
    dynamic _revSource = await SessionManager().get("_revSource");
    dynamic userID = await SessionManager().get("userID");
    var response = await http.get(Uri.parse("http://165.232.154.198/ccb/api/payment-history-v2?LoginID=$LoginID&revSource=$_revSource&userID=$userID"));
    var data = jsonDecode(response.body.toString());
    PaymentHistoryList = [];
    if (response.statusCode == 200) {
      for (Map i in data) {
        PaymentHistoryList.add(UserPaymentHistoryModel.fromJson(i));
      }
      return PaymentHistoryList;
    } else {
      return PaymentHistoryList;
    }
    EasyLoading.dismiss();
  }

  Future<void> _getInvoicePDF(invoiceID) async {
    final Uri invoicePdfUrl = Uri.parse('http://165.232.154.198/ccb/api/user-payment-pdf/' + invoiceID);
    if (!await launchUrl(
      invoicePdfUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $invoicePdfUrl';
    }
  }
}
