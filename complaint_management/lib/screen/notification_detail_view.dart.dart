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
import '../config/palette.dart';
import '../model/notification_model.dart';
import 'bill/history.dart';
import 'bill/paybale_bill_head_list.dart';
import 'bill/paybale_bill_list.dart';
import 'complain_create.dart';
import 'complain_list.dart';
import 'home.dart';
import 'notification_list.dart';


class NotificationDetailViewPage extends StatefulWidget {
  NotificationDetailViewPage({Key? key, required this.NotifyID}) : super(key: key);
  final NotifyID;
  @override
  State<NotificationDetailViewPage> createState() => _NotificationDetailViewPageState(NotifyID:NotifyID);
}

class _NotificationDetailViewPageState extends State<NotificationDetailViewPage> {
  _NotificationDetailViewPageState({Key? key, required this.NotifyID});
  final NotifyID;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  List<NotificationModel> NotificationList = [];
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    initFunc();
    super.initState();

  }
  var counter = 0;
  var userImgs;
  //// for button area


  initFunc() async {
   var  userImgsTemp = await SessionManager().get("userImgs");
    setState(() {
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    });
  }
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
                MaterialPageRoute(builder: (context) => NotificationPage()),
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
          new Stack(
            children: <Widget>[
              SizedBox(height: 50),
              new IconButton(icon: Icon(Icons.notifications,size: 30,), onPressed: () {
                setState(() {
                  counter = 0;
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                  });
                });
              }),
              counter != 0 ? new Positioned(
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
                    '$counter',
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
            // Text('Notification Detail:',style:TextStyle(fontSize: 22.0,color:Palette.primaryBG,fontWeight: FontWeight.bold)),
            // Divider(height: 1,color:Colors.black38),
            SizedBox(height: 10),
            Expanded(child: FutureBuilder(
                future: GetNotificationData(),
                builder: (context,snapshort){
                  if(!snapshort.hasData){
                    return Text('',style: TextStyle(color:Palette.primaryBG,fontSize: 25));
                  }else{
                    return ListView.builder(
                        itemCount: NotificationList.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Palette.primaryBGUnselect,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              'images/icons/new/notification.jpg',
                                              height: 60.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Expanded(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(NotificationList[index].title.toString(),style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                                  SizedBox(height: 2),
                                                  Divider(height: 1,color:Colors.black38),

                                                  SizedBox(height: 5),
                                                  Text(NotificationList[index].desc.toString(),style:TextStyle(fontSize: 15))
                                                ],
                                              )),

                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                // mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.white,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                                      child: Container(
                                                          child: Text(NotificationList[index].diffTime.toString(),style:TextStyle(fontSize: 12))
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NotificationPage()),
                                );
                              });
                            },
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
        index: 1,
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

  Future<List<NotificationModel>> GetNotificationData() async {
    EasyLoading.show(status: 'loading...');
    var response = await http.get(Uri.parse("http://165.232.154.198/ccb/api/get-notification-list?id="+NotifyID.toString()));
    var data = jsonDecode(response.body.toString());
    NotificationList = [];
    if(response.statusCode == 200){
      for(Map i in data){
        NotificationList.add(NotificationModel.fromJson(i));
      }
      return NotificationList;
    }else{
      return NotificationList;
    }
    EasyLoading.dismiss();
  }


}
