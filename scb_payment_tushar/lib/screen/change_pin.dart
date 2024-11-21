import 'dart:io' as io;
import 'dart:io';
import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../config/palette.dart';
import '../model/notification_model.dart';
import 'bill/4N_07_payment_history.dart';
import 'bill/paybale_bill_head_list.dart';
import 'bill/4N_04_paybale_bill_list.dart';
import 'complain_list.dart';
import 'custom_animation.dart';
import 'home.dart';
import 'login_signup.dart';
import 'notification_list.dart';



class ChangePinPage extends StatefulWidget {
  const ChangePinPage({Key? key}) : super(key: key);
  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage>{
  int _page = 0;
  var userID;
 var confirmNewPINError = false;
 var newPINError = false;
 var oldPINError = false;
 var confirmNewPINErrorMsg;
 var newPINErrorMsg;
 var oldPINErrorMsg;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<NotificationModel> NotificationList = [];
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    initFunc();
    super.initState();
  }
  TextEditingController oldPINController = new TextEditingController();
  TextEditingController newPINController = new TextEditingController();
  TextEditingController confirmNewPINController = new TextEditingController();

  var LoginID;
  var userImgs;
  var _revSource;
  initFunc() async {
    LoginID = await SessionManager().get("LoginID");
    userID = await SessionManager().get("userID");
    await SessionManager().set("isNotify",false);
    var userImgsTemp = await SessionManager().get("userImgs");
    var _revSource = await SessionManager().get("_revSource");
    // var userImgsTemp = await SessionManager().get("userImgs");
    setState(() {
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    });
  }
  var counter = 0;

  setChangePIN() async {
    var _revSource = await SessionManager().get("_revSource");
    Response response = await post(
        Uri.parse('http://165.232.154.198/ccb/api/user-change-pin'),
        body:{
          'LoginID':LoginID.toString(),
          '_revSource':_revSource.toString(),
          'userID':userID.toString(),
          'oldPin':oldPINController.text.toString(),
          'newPin':newPINController.text.toString(),
          'confirmPin':confirmNewPINController.text.toString(),
        }
    );
    var data = jsonDecode(response.body.toString());

    Navigator.of(context).pop();
    if(response.statusCode == 200) {

      if(data['status']){
        _ShowMessage(context,data['status'],data['message']);
        Timer(Duration(seconds: 1), () async {
          await SessionManager().destroy();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginSignupScreen()),
          );
        });
      }else{
        _ShowMessage(context,false,data['message']);
        Timer(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePinPage()),
          );
        });
      }

    }else{
      _ShowMessage(context,false,data['message']);
      Timer(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangePinPage()),
        );
      });
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
        leading: new IconButton(
            icon: new Icon( Icons.arrow_back_ios, color: Colors.white,  ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComplainPage()),
              );
            }
        ),
        backgroundColor: Palette.primaryBG,
        elevation: 1,
        titleSpacing: 0.0,
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
            SizedBox(height: 2),
            Text('Change your PIN:',style:TextStyle(fontSize: 22.0,color:Palette.textClrGrayDark,fontWeight: FontWeight.bold)),
            Divider(height: 1,color:Colors.black38),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                children: [
                  Container(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text('Old PIN:',style: TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                oldPINError ? Text(oldPINErrorMsg.toString(),style: TextStyle(fontSize: 16,color: Colors.red),) : Text(''),
                              ],),
                              TextField(
                                obscureText: true,
                                controller: oldPINController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '',
                                ),
                              ),
                              // isInvalidTitle ? Text(TitleMesg.toString(),style: TextStyle(color: Colors.red),) : Text(''),
                              SizedBox(height: 10),
                              Row(children: [
                                Text('New PIN:',style: TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                newPINError ? Text(newPINErrorMsg.toString(),style: TextStyle(fontSize: 16,color: Colors.red),) : Text(''),
                              ],),
                              TextField(
                                obscureText: true,
                                controller: newPINController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '',
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(children: [
                                Text('Confirm New PIN:',style: TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                confirmNewPINError ? Text(confirmNewPINErrorMsg.toString(),style: TextStyle(fontSize: 16,color: Colors.red),) : Text(''),
                              ],),
                              TextField(
                                obscureText: true,
                                controller: confirmNewPINController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '',
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: (){
                                  var isValid = true;
                                  if(oldPINController.text.length < 4){
                                    setState(() {
                                      oldPINError = true;
                                      oldPINErrorMsg = 'This PIN is too short.';
                                    });
                                  }else{
                                    setState(() {
                                      oldPINErrorMsg = '';
                                      oldPINError = false;
                                    });
                                  }

                                  if(newPINController.text.length < 4){
                                    setState(() {
                                      newPINError = true;
                                      newPINErrorMsg = 'This PIN is too short.';
                                    });
                                  }else{
                                    setState(() {
                                      newPINErrorMsg = '';
                                      newPINError = false;
                                    });
                                  }


                                  if(confirmNewPINController.text.length < 4){
                                    setState(() {
                                      confirmNewPINError = true;
                                      confirmNewPINErrorMsg = 'This PIN is too short.';
                                    });

                                  }
                                  else if(newPINController.text != confirmNewPINController.text){
                                    setState(() {
                                      confirmNewPINError = true;
                                      confirmNewPINErrorMsg = 'Confirm PIN not matching';
                                    });

                                  }
                                  else{
                                    setState(() {
                                      confirmNewPINErrorMsg = '';
                                      confirmNewPINError = false;
                                    });

                                  }

                                  if(oldPINError == false && newPINError == false && confirmNewPINError == false){
                                    _fetchData(context);
                                    setChangePIN();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Palette.primaryBG,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.send,size:28,color: Colors.white,),
                                    SizedBox(width:10),
                                    Text('Send',style: TextStyle(fontSize: 18),)
                                  ],
                                ),
                              ),
                            ],)
                        ],
                      )
                  ),

                ],

              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 4,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.white,),
          Icon(Icons.notifications_on, size: 30,color: Colors.white),
          Image.asset(
            'assets/images/icons/new/pay_icon.png',
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
  void _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
  }

  void _ShowMessage(BuildContext context, bool status, String Msg) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return GestureDetector(
            child: Dialog(
              // The background color
              backgroundColor: status ? Colors.green.withAlpha(200) : Colors.red.withAlpha(200),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Some text
                    status ? Icon(Icons.check_circle_outlined,size: 60,color: Colors.white,) : Icon(Icons.highlight_remove,size: 60,color: Colors.white,),
                    SizedBox(
                      height: 15,
                    ),
                    Text(Msg,style: TextStyle(color: Colors.white)),

                  ],
                ),
              ),
            ),
            onTap: (){
              Navigator.of(context).pop();
              if(status){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                );
              }

            },
          );
        });
  }
}
