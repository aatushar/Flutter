import 'package:flutter/material.dart';
import 'package:test_flutter/Page/all_publictain_wise_book_list_view_page.dart';
import 'package:test_flutter/Page/login_page.dart';
import 'package:test_flutter/Page/registrationpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home:LoginPage()

    );
}
}

