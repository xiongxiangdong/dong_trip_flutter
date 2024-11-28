import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;

  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  static goToLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  static goToHome() {
    Navigator.pushReplacement(
        _context!!, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
