import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/util/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updateContext(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hi"),
        actions: [_loginOut()],
      ),
    );
  }

  _loginOut() {
    return const ElevatedButton(
        onPressed: LoginDao.getKline, child: Text("Login Out"));
  }
}
