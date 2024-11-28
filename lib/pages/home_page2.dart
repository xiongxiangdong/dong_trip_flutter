import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [_logout()],
      ),
    );
  }

  _logout() {
    return const ElevatedButton(
        onPressed: LoginDao.logOut, child: Text("Login out"));
  }
}
