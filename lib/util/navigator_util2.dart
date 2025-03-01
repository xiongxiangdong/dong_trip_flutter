import 'package:flutter/material.dart';

import '../pages/home_page3.dart';
import '../pages/login_page2.dart';

class NavigatorUtil2 {
  static BuildContext? _context;

  static setContext(BuildContext ct) {
    _context = ct;
  }

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static goLogin() {
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage2()));
  }

  static goToHome(BuildContext context) {
    //不返回
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage3()));
  }

  //返回上一页
  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
