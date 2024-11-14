import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/Page/registrationpage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(500),

                  child: Image.network("https://media.licdn.com/dms/image/v2/D5603AQEvm"
                      "B8AgjlwnA/profile-displayphoto-"
                      "shrink_400_400/profile-displayphoto-shrink_400_400/0/1702064362737?e=1736380800&v="
                      "beta&t=ZRWqD7NRn4ta8tY062eMVhyxnBEYEDLUnVtwJB1_l4s", height: 100, errorBuilder: (_,__,___){
                    return Icon(Icons.image,size: 50,);
                  },)),
                    Text("Md. Abdul ALim Tushar"),
                    Text("aatuashar05@gmail.com", style: TextStyle(fontSize: 13),)
            ],
        ))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password)),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                String em = email.text;
                String pass = password.text;
                print('Email : $em, Password : $pass');
              },
              child: Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.lato().fontFamily),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
   GestureDetector(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),
       );

     },
       child: Text(
         "Registration",
         style: TextStyle(
           fontWeight: FontWeight.w500,
           fontFamily: GoogleFonts.lato().fontFamily,
           color: Colors.blue,
           decoration: TextDecoration.underline,
         ),
       )
   )
          ],
        ),
      ),
    );
  }
}
