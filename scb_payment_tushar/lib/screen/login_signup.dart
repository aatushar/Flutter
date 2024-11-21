import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:scb_payment_tushar/screen/bill/4N_03_shop_wise_demand_charge.dart';

import '../config/palette.dart';
import 'home.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = false;
  bool isMale = true;
  bool isRememberMe = false;
  var submitCount = 0;
  final PhoneNumContrl = TextEditingController();
  final PasswordContrl = TextEditingController();
  var _phoneNumErrorText = '';
  bool _isPhoneNumError = false;
  var _passwordErrorText = '';
  bool _isPasswordError = false;
  int _revenueLogin = 2;

  Login(userPhone,userPass) async {
    if(userPhone == ''){
      _isPhoneNumError = true;
      _phoneNumErrorText = 'Phone number is Empty';
    }
    else{
      _isPhoneNumError = false;
      _phoneNumErrorText = '';
    }
    if(_revenueLogin == 1){
      if(userPhone.length != 11){
        _isPhoneNumError = true;
        _phoneNumErrorText = 'Phone number Invalid';
      }
    }
    if(userPass == ''){
      _isPasswordError = true;
      _passwordErrorText = 'Password is Empty';
    }
    else if(userPass.length < 4){
      _isPasswordError = true;
      _passwordErrorText = 'Password is too short';
    }else{
      _isPasswordError = false;
      _passwordErrorText = '';
    }
    if(_isPasswordError == false && _isPhoneNumError == false){
      await LoginInfo(userPhone,userPass);
      print('sumited');
    }
  }

  LoginInfo(userPhone,userPass) async {
    print('ss=>'+_revenueLogin.toString());
    try{
      Response response = await post(
          Uri.parse('http://165.232.154.198/ccb/api/user-login'),
          body:{
            'userPhone':userPhone,
            'userPass':userPass,
            '_revenueLogin':_revenueLogin.toString(),
          }
      );
      var data = jsonDecode(response.body.toString());
      print(data);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print(_revenueLogin);
        if(data['status']){
          if(data['isActive']){
              var sessionManager = SessionManager();
              await sessionManager.set("userID", data['userData']['user_id']);
              await sessionManager.set("_revSource", _revenueLogin.toString());
              // await sessionManager.set("_revSource",2);
              await sessionManager.set("userName",data['userData']['user_name']);
              await sessionManager.set("LoginID",data['userData']['login_id']);
              await sessionManager.set("LoginUser",data['userData']['login_user']);
              await sessionManager.set("MobileNo", data['userData']['mobile_no'] == null ? '' : data['userData']['mobile_no']);
              await sessionManager.set("address", data['userData']['address'] == null ? '' : data['userData']['address']);
              await sessionManager.set("Email", data['userData']['email'] == null ? '' : data['userData']['email']);
              await sessionManager.set("City", data['userData']['city'] == null ? '' : data['userData']['city']);
              await sessionManager.set("userImgs", data['userData']['user_img'] == null ? '' : data['userData']['user_img']);
              await GetNotificationData();
              dynamic userID = await SessionManager().get("userID");
              print(userID);
              if(userID != ''){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopWiseDemandCharge()),
                );
                setState((){});
              }
          }else{
            _isPhoneNumError = true;
            _phoneNumErrorText = 'User is deactivate';
          }
        }else{
          _isPasswordError = true;
          _passwordErrorText = 'Invalid User Password';
          print('Invalid User Password');
        }
        setState(() {});
      }else{
        print('Login Failed');
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  GetNotificationData() async {
    var response = await http.get(Uri.parse("http://165.232.154.198/ccb/api/get-notification-list?check=1"));
    var data = jsonDecode(response.body.toString());
    await SessionManager().set("totalNotify",data['itemCount']);
    await SessionManager().set("isNotify",false);
  }

  @override
  void dispose() {
    PhoneNumContrl.dispose();
    PasswordContrl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.jpg"),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: EdgeInsets.only(top: 50, left: 20),
                  color: Color.fromRGBO(255, 255, 255,.9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo_new.jpg"),
                            fit: BoxFit.fill,
                          ),
                          // shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "CUMILLA CANTT BOARD",
                            style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Palette.primaryBG,
                              fontWeight: FontWeight.bold,

                            ),
                           ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            // Trick to add the shadow for the submit button
            buildBottomHalfContainer(true),
            //Main Contianer for Login and Signup
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              top: isSignupScreen ? 200 : 200,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                curve: Curves.bounceInOut,
                height: isSignupScreen ? 250 : 250,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5),
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap:(){
                              setState((){
                                isSignupScreen = false;
                                PhoneNumContrl.text = '';
                                PasswordContrl.text = '';
                                _isPhoneNumError = false;
                                _isPasswordError = false;
                                _revenueLogin = 2;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Market",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen
                                          ? Palette.activeColor
                                          : Palette.textColor1),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Color.fromRGBO(236, 31, 39,1),
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                                PhoneNumContrl.text = '';
                                PasswordContrl.text = '';
                                _isPhoneNumError = false;
                                _isPasswordError = false;
                                _revenueLogin = 1;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "DOHS",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Palette.activeColor
                                          : Palette.textColor1),
                                ),
                                if(isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Color.fromRGBO(236, 31, 39,1),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSignupScreen) buildSignupSection(),
                      if (!isSignupScreen) buildSigninSection()
                    ],
                  ),
                ),
              ),
            ),
            // Trick to add the submit button
            buildBottomHalfContainer(false),
            // Bottom buttons
          ],
        ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              obscureText: false,
              controller: PhoneNumContrl,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.home,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Enter Shop Number',
                  errorText: _isPhoneNumError ? _phoneNumErrorText : null,
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1)

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: PasswordContrl,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Password',
                  errorText: _isPasswordError ? _passwordErrorText : null,
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1)
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1))
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.number,
              controller: PhoneNumContrl,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: '01XX-XXXXXX',
                  errorText: _isPhoneNumError ? _phoneNumErrorText : null,
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1)

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: PasswordContrl,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Password',
                  errorText: _isPasswordError ? _passwordErrorText : null,
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1)
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1))
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          foregroundColor: Colors.white, side: BorderSide(width: 1, color: Color.fromRGBO(134, 123, 240,1)),
          minimumSize: Size(145, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.decelerate,
      top: isSignupScreen ? 400 : 400,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Palette.Shadow50,
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? new InkWell(
                child: new Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Palette.Shadow50, Palette.Shadow70],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Palette.Shadow30,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, .2))
                      ]),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  print(PhoneNumContrl.text);
                  submitCount = submitCount+1;
                  setState((){showShadow = true;});
                    await Login(PhoneNumContrl.text,PasswordContrl.text);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomePage()),
                  // );

                },
              )
              : Center(),
        ),
      ),
    );
  }
}
