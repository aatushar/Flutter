
import 'package:book_store/screens/screen/bill/00_compnay_list.dart';
import 'package:book_store/screens/screen/screens/add_member_screen.dart';
import 'package:book_store/screens/screen/screens/booking_screen.dart';
import 'package:book_store/screens/screen/screens/calendar_screen.dart';
import 'package:book_store/screens/screen/screens/event_booking_screen.dart';
import 'package:book_store/screens/screen/screens/filter_main_screen.dart';
import 'package:book_store/screens/screen/screens/filter_screen.dart';
import 'package:book_store/screens/screen/screens/food_home_screen.dart';
import 'package:book_store/screens/screen/screens/hall_room_booking.dart';
import 'package:book_store/screens/screen/screens/home_screen.dart';
import 'package:book_store/screens/screen/screens/home_screen_main.dart';
import 'package:book_store/screens/screen/screens/login_screen.dart';
import 'package:book_store/screens/screen/screens/member_derectory_screen.dart';
import 'package:book_store/screens/screen/screens/member_profile_screen.dart';
import 'package:book_store/screens/screen/screens/register_screen.dart';
import 'package:book_store/screens/screen/screens/setting_screen.dart';
import 'package:book_store/src/customer_features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';




class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String calender = '/calender';
  static const String homepage = '/homepage';
  static const String add = '/add';
  static const String book = '/book';
  static const String evn = '/evn';
  static const String filter = '/filter';
  static const String hallroombook = '/hallroombook';
  static const String memberdirectory = '/memberdirectory';
  static const String foodhome = '/foodhome';
  static const String filtermain = '/filtermain';
  static const String setting = '/setting';
  static const String paydue = '/paydue';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => MemberProfileScreen());
      case calender:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case add:
        return MaterialPageRoute(builder: (_) => AddMemberScreen());
      case book:
        return MaterialPageRoute(builder: (_) => BookingScreen());
      case evn:
        return MaterialPageRoute(builder: (_) => EventsScreen());
      case filter:
        return MaterialPageRoute(builder: (_) => FilterScreen());
      case hallroombook:
        return MaterialPageRoute(builder: (_) => HallBookingScreen());
      case memberdirectory:
        return MaterialPageRoute(builder: (_) => MembersDirectoryScreen());
      case foodhome:
        return MaterialPageRoute(builder: (_) => FoodHomeScreen());
      case filtermain:
        return MaterialPageRoute(builder: (_) => MemberSearchScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
     case paydue:
     return MaterialPageRoute(builder: (_) => CompanyScreen());

      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());

      default:

        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page Not Found!")),
          ),
        );
    }
  }
}
