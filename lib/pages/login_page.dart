import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/util/string_util.dart';
import 'package:trip_flutter/widget/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/margin.dart';
import '../widget/login_widget2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool enLogin = false;
  String pwd = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [..._getBg(), _getContent()],
      ),
    );
  }

  _getBg() {
    return [
      Positioned.fill(
          child: Image.asset(
        "images/login-bg1.jpg",
        //缩小方式
        fit: BoxFit.cover,
      )),
      Positioned.fill(
        child:
            //BoxDecoration 设置描边，背景色s
            Container(decoration: const BoxDecoration(color: Colors.black54)),
      )
    ];
  }

  _getContent() {
    return Positioned.fill(
        left: 15,
        right: 15,
        child: ListView(
          children: [
            getMargin(height: 35),
            const Text(
              "登录",
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            getMargin(height: 35),
            InputWidget(
              "请输入账号",
              valueChanged: (text) {
                name = text;
                _check();
              },
            ),
            getMargin(height: 35),
            InputWidget(
              "请输入密码",
              pwd: true,
              valueChanged: (text) {
                pwd = text;
                _check();
              },
            ),
            getMargin(height: 35),
            LoginWidget2(
              "Login",
              enableLogin: enLogin,
              //() => ??1
              callback: () => _login(context),
            ),
            getMargin(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => jumpRegistration(),
                child: const Text(
                  "注册",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }

  _check() {
    //enLogin = isNotEmpty(pwd) && isNotEmpty(name);
    bool enable;
    if (isNotEmpty(pwd) && isNotEmpty(name)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      enLogin = enable;
      print("enLogin:${enLogin}");
    });
  }

  _login(context) async {
    try {
      //dong 123456
      LoginDao.getKline();
      //LoginDao.login(name: name, pwd: pwd);
      //NavigatorUtil.goToHome(context);
    } catch (e) {
      print(e);
    }
  }

  //跳转到注册页面
  jumpRegistration() async {
    //跳转到接口后台注册账号
    Uri uri = Uri.parse(
        "https://api.geekailab.com/uapi/swagger-ui.html#/Account/registrationUsingPOST");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $uri";
    }
  }
}
