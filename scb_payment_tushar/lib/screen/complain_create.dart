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
import 'notification_list.dart';



class ComplainCreatePage extends StatefulWidget {
  const ComplainCreatePage({Key? key}) : super(key: key);
  @override
  State<ComplainCreatePage> createState() => _ComplainCreatePageState();
}

class _ComplainCreatePageState extends State<ComplainCreatePage>{
  int _page = 0;
  var userID;
  var isInvalidTitle = false;
  var TitleMesg = null;
  var isInvalidDesc = false;
  var DescMesg = null;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<NotificationModel> NotificationList = [];
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    initFunc();
    super.initState();
  }
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

  var userImgs;
  initFunc() async {
    userID = await SessionManager().get("userID");
    await SessionManager().set("isNotify",false);
    var userImgsTemp = await SessionManager().get("userImgs");
    setState(() {
      userImgs = (userImgsTemp != '') ? userImgsTemp : 'demo_user.png';
    });
  }
  var counter = 0;

  var imageFile1;
  var imageFile2;
  var imageFile3;
  var imageFile4;
  var imageFile5;

  Future<File?> selectImages(int i) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {

      if(i == 1){
        imageFile1 = null;
      }
      else if(i == 2){
        imageFile2 = null;
      }
      else if(i == 3){
        imageFile3 = null;
      }
      else if(i == 4){
        imageFile4 = null;
      }
      else if(i == 5){
        imageFile5 = null;
      }


      if(imageFile1 == null){
        imageFile1 = pickedFile!;
      }
      else if(imageFile2 == null){
        imageFile2 = pickedFile!;
      }
      else if(imageFile3 == null){
        imageFile3 = pickedFile!;
      }
      else if(imageFile4 == null){
        imageFile4 = pickedFile!;
      }
      else{
        imageFile5 = pickedFile!;
      }
    });


    Navigator.of(context).pop();
  }

  Future<File?> GetImageByCamera(int i) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      if(i == 1){
        imageFile1 = null;
      }
      else if(i == 2){
        imageFile2 = null;
      }
      else if(i == 3){
        imageFile3 = null;
      }
      else if(i == 4){
        imageFile4 = null;
      }
      else if(i == 5){
        imageFile5 = null;
      }

      if(imageFile1 == null){
        imageFile1 = pickedFile!;
      }
      else if(imageFile2 == null){
        imageFile2 = pickedFile!;
      }
      else if(imageFile3 == null){
        imageFile3 = pickedFile!;
      }
      else if(imageFile4 == null){
        imageFile4 = pickedFile!;
      }
      else{
        imageFile5 = pickedFile!;
      }
    });
    Navigator.of(context).pop();

  }

  sendComplainInfo() async {
    print('---------- Start -------');
    var uri = Uri.parse('http://165.232.154.198/ccb/api/complain-create');
    var request = http.MultipartRequest('POST', uri);
      request.fields['user_id'] = userID.toString();
      request.fields['title'] = titleController.text.toString();
      request.fields['desc'] = descController.text.toString();
    if(imageFile1 != null){
      request.files.add(await http.MultipartFile.fromPath(
          'img', imageFile1!.path,
          contentType: MediaType('application', 'jpeg')));
    }

    if(imageFile2 != null){
      request.files.add(await http.MultipartFile.fromPath(
          'img2', imageFile2!.path,
          contentType: MediaType('application', 'jpeg')));
    }

    if(imageFile3 != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'img3', imageFile3!.path,
          contentType: MediaType('application', 'jpeg')));
    }

    if(imageFile4 != null){
      request.files.add(await http.MultipartFile.fromPath(
          'img4', imageFile4!.path,
          contentType: MediaType('application', 'jpeg')));
    }


    if(imageFile5 != null){
      request.files.add(await http.MultipartFile.fromPath(
          'img5', imageFile5!.path,
          contentType: MediaType('application', 'jpeg')));
    }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    Navigator.of(context).pop();
    if(response.statusCode == 200) {
      if(respStr.isNotEmpty){
        _ShowMessage(context,true,'Complain Inserted Successfully');
      }else{
        _ShowMessage(context,false,'Insert Failed!');
      }
    }else{
      _ShowMessage(context,false,'Insert Failed!');
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
            Text('Complain:',style:TextStyle(fontSize: 22.0,color:Palette.textClrGrayDark,fontWeight: FontWeight.bold)),
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
                                Text('Title:',style: TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                isInvalidTitle ? Text(TitleMesg.toString(),style: TextStyle(fontSize: 16,color: Colors.red),) : Text(''),
                              ],),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Text here',
                                ),
                              ),
                              // isInvalidTitle ? Text(TitleMesg.toString(),style: TextStyle(color: Colors.red),) : Text(''),
                              SizedBox(height: 10),
                              Row(children: [
                                Text('Description:',style: TextStyle(fontSize: 16)),
                                SizedBox(width: 5),
                                isInvalidDesc ? Text(DescMesg.toString(),style: TextStyle(fontSize: 16,color: Colors.red),) : Text(''),
                              ],),
                              TextField(
                                controller: descController,
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.red)
                                  ),
                                  hintText: 'Enter Text here',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Container(child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Palette.primaryBGUnselect,
                                      child: (imageFile1==null)? Center(child: Icon(Icons.add_a_photo,color: Palette.primaryBG20,)) : Image.file( File( imageFile1!.path),height: 80,width: 80,fit: BoxFit.cover,),
                                    ),
                                    onTap: (){
                                      setState((){
                                        _SelectImageSource(context,1);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  (imageFile1==null) ? Text('') : GestureDetector(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Palette.primaryBGUnselect,
                                      child: (imageFile2==null)? Center(child: Icon(Icons.add_a_photo,color: Palette.primaryBG20,)) : Image.file( File( imageFile2!.path),height: 80,width: 80,fit: BoxFit.cover,),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        _SelectImageSource(context,2);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  (imageFile2==null) ? Text('') : GestureDetector(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Palette.primaryBGUnselect,
                                      child: (imageFile3==null)? Center(child: Icon(Icons.add_a_photo,color: Palette.primaryBG20,)) : Image.file( File( imageFile3!.path),height: 80,width: 80,fit: BoxFit.cover,),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        _SelectImageSource(context,3);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  (imageFile3==null) ? Text('') : GestureDetector(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Palette.primaryBGUnselect,
                                      child: (imageFile4==null)? Center(child: Icon(Icons.add_a_photo,color: Palette.primaryBG20,)) : Image.file( File( imageFile4!.path),height: 80,width: 80,fit: BoxFit.cover,),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        _SelectImageSource(context,4);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  (imageFile4==null) ? Text('') : GestureDetector(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Palette.primaryBGUnselect,
                                      child: (imageFile5==null)? Center(child: Icon(Icons.add_a_photo,color: Palette.primaryBG20,)) : Image.file( File( imageFile5!.path),height: 80,width: 80,fit: BoxFit.cover,),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        _SelectImageSource(context,5);
                                      });
                                    },
                                  ),
                                ],
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: (){
                                  if(titleController.text.length < 1){
                                    setState(() {
                                      isInvalidTitle = true;
                                      TitleMesg = 'This field is required';
                                    });
                                  }else{
                                    setState(() {
                                      isInvalidTitle = false;
                                      TitleMesg = null;
                                    });
                                  }
                                  if(descController.text.length < 1){
                                    setState(() {
                                      isInvalidDesc = true;
                                      DescMesg = 'This field is required';
                                    });
                                  }
                                  else if(descController.text.length < 10){
                                    setState(() {
                                      isInvalidDesc = true;
                                      DescMesg = 'Please enter at least 10 characters';
                                    });
                                  }
                                  else{
                                    setState(() {
                                      isInvalidDesc = false;
                                      DescMesg = 'This field is required';
                                    });
                                  }

                                  print(descController.text.length);
                                  if(titleController.text.length > 1 && descController.text.length > 10){
                                    _fetchData(context);
                                    sendComplainInfo();
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
        barrierDismissible: true,
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
                  MaterialPageRoute(builder: (context) => ComplainPage()),
                );
              }

            },
          );
        });
  }

  void _SelectImageSource(BuildContext context, int i) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  Text('Select Image Source',style: TextStyle(fontSize: 30,color: Colors.black26)),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: (){
                                GetImageByCamera(i);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Palette.primaryBG,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt,size:28,color: Colors.white,),
                                  SizedBox(width:16),
                                  Text('Camera')
                                ],
                              ),
                            ),

                            ElevatedButton(
                              onPressed: (){
                                selectImages(i);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Palette.primaryBG,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.photo,size:28,color: Colors.white,),
                                  SizedBox(width:16),
                                  Text('Gallery')
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                      ]),
                    ),
                  )
                  // Some text

                ],
              ),
            ),
          );
        });
  }
}
