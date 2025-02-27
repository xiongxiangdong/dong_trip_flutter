import 'package:flutter/material.dart';
import 'package:trip_flutter/util/string_util.dart';
import 'package:trip_flutter/widget/login_widget2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dao/login_dao3.dart';
import '../util/margin.dart';
import '../util/navigator_util2.dart';
import '../widget/input_widget2.dart';
import '../widget/input_widget3.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  String? pwd;
  String? userName;
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [..._getBack(), _getContent(context)],
      ),
    );
  }

  _getBack() {
    return [
      Positioned.fill(
          child: Image.asset(
        "images/login-bg1.jpg",
        fit: BoxFit.cover,
      )),
      Positioned.fill(
          child: Container(
        decoration: const BoxDecoration(color: Colors.black54),
      ))
    ];
  }

  _getContent(BuildContext context) {
    return Positioned.fill(
        left: 25,
        right: 25,
        child: ListView(children: [
          getMargin(height: 50),
          const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          getMargin(height: 50),
          InputWidget2(
            "输入用户名",
            pwd: false,
            textInputType: TextInputType.text,
            valueChanged: (String value) {
              userName = value;
              _checkInput();
            },
          ),
          getMargin(height: 10),
          InputWidget2(
            "输入密码",
            pwd: true,
            textInputType: TextInputType.text,
            valueChanged: (String value) {
              pwd = value;
              _checkInput();
            },
          ),
          getMargin(height: 10),
          InputWidget3(
            "输入密码",
            pwd: true,
            textInputType: TextInputType.text,
            valueChanged: (String value) {
              pwd = value;
              _checkInput();
            },
          ),
          getMargin(height: 10),
          LoginWidget2(
            "Login",
            enable: enable,
            voidCallback: () => _login(context),
          ),
          getMargin(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => jumpRegistration(),
              child: const Text(
                "register",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ]));
  }

  _login(BuildContext context) {
    try {
      //dong 123456
      LoginDao3.login(user: userName!, pwd: pwd!);
      NavigatorUtil2.goToHome(context);
      //LoginDao.login(name: userName!, pwd: pwd!);
    } catch (e) {
      print(e);
    }
  }

  _checkInput() {
    if (isNotEmpty(userName) && isNotEmpty(pwd)) {
      setState(() {
        enable = true;
      });
    } else {
      setState(() {
        enable = false;
      });
    }
  }

  jumpRegistration() async {
    Uri uri = Uri.parse(
        "https://api.geekailab.com/uapi/swagger-ui.html#/Account/registrationUsingPOST");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $uri";
    }
  }
}
