import 'dart:async';
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:scb_payment_tushar/screen/bill/4N_05_monthly_board_rent.dart';
import 'package:scb_payment_tushar/screen/complaintScreen/4N_08_my_complaints.dart';

import 'package:scb_payment_tushar/screen/profile.dart';

import '../config/LogOut.dart';
import '../config/palette.dart';
import 'bill/4N_07_payment_history.dart';
import 'bill/4N_04_paybale_bill_list.dart';
import 'change_pin.dart';
import 'complain_create.dart';
import 'complain_list.dart';
import 'notification_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  var userID ;
  var userName;
  var userTypeID;
  var MobileNo;
  var Email;
  var City;
  var address;
  var _revSource;
  var LoginID;
  var LoginUser;
  var userImgs;


  Future<void> GetUserInfo() async {
    _revSource = await SessionManager().get("_revSource");
    userID = await SessionManager().get("userID");
    userName = await SessionManager().get("userName");
    LoginID = await SessionManager().get("LoginID");
    LoginUser = await SessionManager().get("LoginUser");
    MobileNo = await SessionManager().get("MobileNo");
    address = await SessionManager().get("address");
    Email = await SessionManager().get("Email");
    City = await SessionManager().get("City");
    var userImgsTemp = await SessionManager().get("userImgs");
    userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    setState((){});
  }
  Timer? _timer;
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    GetUserInfo();
    GetNotificationData();
    setState((){});
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if(status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
      Future.delayed(Duration(milliseconds: 50), () {
        EasyLoading.dismiss();
      });
    });
  }
  var counter = 0;
  var totalNotifyCount = 0;
  GetNotificationData() async{
    print('44');
    var response = await http.get(Uri.parse("http://165.232.154.198/ccb/api/get-notification-list?check=1"));
    var data = jsonDecode(response.body.toString());
    var totalNotify = await SessionManager().get("totalNotify");
    if(data['itemCount'] > totalNotify){
      await SessionManager().set("isNotify",true);
    }

    setState(() {
      counter = data['itemCount'] - totalNotify;
      totalNotifyCount = data['itemCount'];
    });
    var isNotify = await SessionManager().get("isNotify");
  }

  //// for button area
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
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
            padding: EdgeInsets.all(5.0),
            child: Container(
              width: 36,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  image: DecorationImage(
                    image: AssetImage("assets/images/user/mostafa2.jpeg"),
                      fit: BoxFit.cover
                  ),
                // border: Border.all(
                //     color: Palette.primaryBGDark,
                //     width: 1.0
                // ),
              ),
            ),
          ),
          new Stack(
            children: <Widget>[
              SizedBox(height: 50),
              new IconButton(icon: Icon(Icons.notifications,size: 30,), onPressed: () {
                setState(() async {
                    await SessionManager().set("isNotify",false);
                    await SessionManager().set("totalNotify",totalNotifyCount);
                    counter = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                });
              }),
              counter.toInt() != 0 ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    "$counter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ) : new Container()
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: (_revSource == 2) ? DecorationImage(
                        image:AssetImage('assets/images/shop-bg.jpg'),
                        fit: BoxFit.cover
                    ) : DecorationImage(
                        image: AssetImage('assets/images/background.jpg'),
                        fit: BoxFit.cover
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.Shadow20,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        spreadRadius: 3,
                      )
                    ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Palette.primaryBG.withOpacity(0),
                            Palette.primaryBG.withOpacity(0),
                          ]
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("", style: TextStyle(color: Colors.white70, fontSize: 30),),

                    ],
                  ),
                ),

              ),
              SizedBox(height: 30,),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,

                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MonthlyBoardRentServiceScreen()),
                        );
                        setState((){});
                      },
                      child: new Container(
                          child: Column(
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Palette.Shadow20,
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
                                                  image: AssetImage('assets/images/icons/new/mobile-payment.png'),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Pay Bill',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyComplaintsPage()),
                        );
                        setState((){});
                      },
                      child: Container(
                          child: Column(
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Palette.Shadow20,
                                      offset: Offset(1, 1),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      // color: Palette.primaryBG60,
                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage('assets/images/icons/new/complain.jpg'),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text('Complain',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await SessionManager().set("isNotify",false);
                        await SessionManager().set("totalNotify",totalNotifyCount);
                        counter = 0;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationPage()),
                        );
                        setState((){});
                      },
                      child: Container(
                        child: Column(
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
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.Shadow20,
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    // color: Palette.primaryBG60,
                                    elevation: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/icons/new/notification.jpg'),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('Notice',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                                ],
                              ),
                            )
                          ],
                        )
                    )
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentHistory()),
                        );
                        setState((){});
                      },
                    child:Container(
                        child: Column(
                          children: [
                            // Container(
                            //   height: 75,
                            //   width: 82,
                            //   padding: EdgeInsets.only(top: 3),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(10),
                            //         topRight: Radius.circular(10),
                            //         bottomLeft: Radius.circular(10),
                            //         bottomRight: Radius.circular(10)
                            //     ),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Palette.Shadow20,
                            //         offset: Offset(1, 1),
                            //         blurRadius: 1,
                            //         spreadRadius: 1,
                            //       )
                            //     ],
                            //   ),
                              // child: Column(
                              //   children: [
                              //     Card(
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(0),
                              //       ),
                              //       // color: Palette.primaryBG60,
                              //       elevation: 0,
                              //       child: Padding(
                              //         padding: EdgeInsets.all(0.0),
                              //         child: Container(
                              //           height: 40,
                              //           width: 40,
                              //           decoration: BoxDecoration(
                              //               image: DecorationImage(
                              //                   image: AssetImage('images/icons/new/invoice.png'),
                              //                   fit: BoxFit.cover
                              //               )
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Text('History',style: TextStyle(color: Palette.primaryBG,fontSize: 14))
                              //   ],
                              // ),
                            // )
                          ],
                        )
                    ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: FutureBuilder(
                      future: SessionManager().get("userName"),
                    builder: (context,snapshot){
                      return Text(snapshot.hasData ? snapshot.data.toString() : '');
                    }
                ),
                accountEmail: FutureBuilder(
                    future: SessionManager().get("LoginUser"),
                    builder: (context,snapshot){
                      return Text(snapshot.hasData ? snapshot.data.toString() : '');
                    }
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user/mostafa2.jpeg"),
                ),

                otherAccountsPictures: <Widget>[
                  // CircleAvatar(
                  //   child: Text(''),
                  //   backgroundColor: Colors.white60,
                  // ),
                  // CircleAvatar(
                  //   child: Text(''),
                  // ),
                ],

                onDetailsPressed: (){},


                decoration: BoxDecoration(
                  color: Palette.primaryBG,

                ),),

              ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(userID.toString(),userName.toString(),MobileNo.toString(),Email.toString(),City.toString(),address.toString(),userImgs.toString())),
                  );
                  setState((){});
                },
              ),


              Divider(),


              ListTile(
                title: Text('Pay Bill'),
                leading: Icon(Icons.arrow_right),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PayableBillList()),
                  );
                },
              ),

              ListTile(
                title: Text('Complain'),
                leading: Icon(Icons.arrow_right),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplainPage()),
                  );
                },
              ),


              ListTile(
                title: Text('Notification'),
                leading: Icon(Icons.arrow_right),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
              ),


              Divider(),


              ListTile(
                title: Text('Change PIN'),
                leading: Icon(Icons.lock_outline),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePinPage()),
                  );
                },
              ),

              Divider(),
              ListTile(
                title: Text('LogOut',style: TextStyle(color: Colors.red),),
                leading: Icon(Icons.logout_outlined,color: Colors.red,),
                onTap: (){
                  LogOut(context);
                  setState((){});
                  print('logout');
                },
              ),
              Divider(),
              ListTile(
                  title: Text('Close'),
                  leading: Icon(Icons.close),
                  onTap: (){
                    Navigator.of(context).pop();}
              ),


            ]
        ),
      ),
      // bottomNavigationBar: buildMyNavBar(context),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
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
                await SessionManager().set("isNotify",false);
                await SessionManager().set("totalNotify",totalNotifyCount);
                counter = 0;
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyComplaintsPage()));
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

