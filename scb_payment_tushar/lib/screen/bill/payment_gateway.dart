import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_paybale_bill_list.dart';

import 'package:webview_flutter/webview_flutter.dart';


import '../../config/palette.dart';


class PayGetWayPage extends StatefulWidget {
  final String payUrl;
  PayGetWayPage({required this.payUrl});
  @override
  State<PayGetWayPage> createState() => _PayGetWayPageState(payUrl);
}

class _PayGetWayPageState extends State<PayGetWayPage> {
  final String payUrl;
  var isPaymentFinish = false;
  _PayGetWayPageState(this.payUrl);
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    EasyLoading.show(status: 'loading...');
    getInitFunc();
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      EasyLoading.dismiss();
    });
  }
  var userImgs;
  getInitFunc() async {
    var userImgsTemp = await SessionManager().get("userImgs");
    setState(() {
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    });
  }
  TextEditingController  monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var value;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primaryBG,
          elevation: 0,
          // title: Text("Home - Online Payment"),
          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: Colors.white,  ),
            onTap: () {
              Navigator.pop(context);
            } ,
          ) ,
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
        // body: WebView(
        //   initialUrl: payUrl,
        //   javascriptMode: JavaScriptMode.unrestricted,
        //   onPageFinished: (url){
        //     print(url.toLowerCase());
        //     if(url.toLowerCase().contains("https://zit-solution.com")){
        //       print(url.toLowerCase().contains("status"));
        //       if(url.toLowerCase().contains("https://zit-solution.com/loading/")){
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => PayableBillList()),
        //         );
        //         setState((){});
        //
        //       }else{
        //         print('stay page');
        //       }
        //     }
        //     else {
        //       print('not successfull');
        //     }
        //     print('loading..');
        //   },
        //
        // )
    );
  }
}
