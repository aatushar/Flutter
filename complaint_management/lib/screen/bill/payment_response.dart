import 'package:complaint_management/screen/bill/paybale_bill_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/palette.dart';


class PayResponseStatusPage extends StatefulWidget {
  final String payUrl;
  final String invoiceNo;
  PayResponseStatusPage({required this.payUrl, required this.invoiceNo});
  @override
  State<PayResponseStatusPage> createState() => _PayResponseStatusPageState(payUrl,invoiceNo);
}

class _PayResponseStatusPageState extends State<PayResponseStatusPage> {
  final String payUrl;
  final String invoiceNo;
  var isPaymentFinish = false;
  _PayResponseStatusPageState(this.payUrl, this.invoiceNo);
  late WebViewController _controller;

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
          onTap: () async {
            await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PayableBillList()));
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
      body:Stack(
        children: [
          WebView(
            initialUrl: widget.payUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () async {
                await _getInvoicePDF(invoiceNo);
                await Navigator.push(context,MaterialPageRoute(builder: (context)=> new PayableBillList()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primaryBG, // Background color
                foregroundColor: Colors.white, // Text (foreground) color
              ),
              child: Text('Download PDF'),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _getInvoicePDF(invoiceID) async {
    final Uri invoicePdfUrl = Uri.parse('http://165.232.154.198/ccb/api/user-payment-pdf/'+invoiceID);
    // final Uri invoicePdfUrl = Uri.parse('https://flutter.dev');
    if (!await launchUrl(
      invoicePdfUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $invoicePdfUrl';
    }
  }
}
