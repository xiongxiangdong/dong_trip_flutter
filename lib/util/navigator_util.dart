import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;

  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static goToHome(BuildContext context) {
    //不返回
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  /*static goToLogin(BuildContext context) {
    //不返回
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }*/
  static goToLogin() {
    //不返回
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
