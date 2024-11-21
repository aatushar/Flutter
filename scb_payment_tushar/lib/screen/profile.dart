import 'dart:io' as io;
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../config/palette.dart';
import 'home.dart';



class ProfileScreen extends StatefulWidget {
  final String _userID;
  final String _userName;
  final String _mobileNo;
  final String _email;
  final String _City;
  final String _address;
  final String _userImgs;

  ProfileScreen(this._userID, this._userName, this._mobileNo, this._email, this._City, this._address,this._userImgs);
  @override
  _ProfileScreenState createState() => _ProfileScreenState(_userID,_userName,_mobileNo,_email,_City,_address,_userImgs);
}


class _ProfileScreenState extends State<ProfileScreen> {
  final String _userID;
  final String _userName;
  final String _mobileNo;
  final String _email;
  final String _City;
  final String _address;
  final String _userImgs;
  _ProfileScreenState(this._userID, this._userName,this._mobileNo,this._email,this._City,this._address,this._userImgs);
  bool showPassword = false;
  var  _NameController = TextEditingController();
  var  _MobileController = TextEditingController();
  var  _EmailController = TextEditingController();
  var  _CityController = TextEditingController();
  var  _AddressController = TextEditingController();
  var userImgs;

  @override
  void initState() {
    _NameController = new TextEditingController(text: _userName.toString());
    _MobileController = new TextEditingController(text: _mobileNo.toString());
    _EmailController = new TextEditingController(text: _email.toString());
    _CityController = new TextEditingController(text: _City.toString());
    _AddressController = new TextEditingController(text: _address.toString());
    super.initState();
  }
  var imageFile1;

  // getData() async{
  //   var userImgsTemp = await SessionManager().get("userImgs");
  //   setState(() {
  //     userImgs = userImgsTemp;
  //   });
  // }
  Future<File?> selectImages(int i) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState((){
      imageFile1 = pickedFile!;
    });
    ChanageProfilePic();
  }

  Future<File?> GetImageByCamera(int i) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
        imageFile1 = pickedFile!;
    });
    ChanageProfilePic();
  }

  ChanageProfilePic() async {
    var uri = Uri.parse('https://scb-bd.com/admin-login/public/api/change-profile-pic');
    var request = http.MultipartRequest('POST', uri);
    request.fields['user_id'] = _userID.toString();
    if(imageFile1 != null){
      request.files.add(await http.MultipartFile.fromPath(
          'img', imageFile1!.path,
          contentType: MediaType('application', 'jpeg')));
    }
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    Navigator.of(context).pop();
    if(response.statusCode == 200) {
      if(respStr.isNotEmpty){
        print(respStr);
        setState(() {});
        var sessionManager = SessionManager();
        await sessionManager.set("userImgs", respStr);
        setState(() {});
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(_userID,_userName,_mobileNo,_email,_City,_address,respStr)),
        );
      }else{
        _ShowMessage(context,false,'Insert Failed!');
      }
    }else{
      _ShowMessage(context,false,'Insert Failed!');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryBG,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Your Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage("assets/images/user/mostafa2.jpeg"),
                              fit: BoxFit.cover
                          )

                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Palette.primaryBG,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                          onTap:(){
                            _SelectImageSource(context,1);
                          },
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _NameController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Full Names',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Enter your full name',
                     ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _MobileController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Mobile No.',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Enter your Mobile',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _EmailController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'E-mail',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Enter your E-mail',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _CityController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'City',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Enter your City',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _AddressController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Address',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Enter your Address',
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     OutlineButton(
              //       padding: EdgeInsets.symmetric(horizontal: 50),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20)),
              //       onPressed: () {},
              //       child: Text("CANCEL",
              //           style: TextStyle(
              //               fontSize: 14,
              //               letterSpacing: 2.2,
              //               color: Colors.black)),
              //     ),
              //     RaisedButton(
              //       onPressed: () {},
              //       color: Palette.primaryBG,
              //       padding: EdgeInsets.symmetric(horizontal: 50),
              //       elevation: 2,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20)),
              //       child: Text(
              //         "SAVE",
              //         style: TextStyle(
              //             fontSize: 14,
              //             letterSpacing: 2.2,
              //             color: Colors.white),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
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
            },
          );
        });
  }

}