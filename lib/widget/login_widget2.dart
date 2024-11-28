import 'package:flutter/material.dart';

class LoginWidget2 extends StatelessWidget {
  const LoginWidget2(this.name,
      {super.key, required this.callback, required this.enableLogin});

  final String name;
  final VoidCallback? callback;
  final bool enableLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enableLogin ? callback : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Colors.orange,
      disabledColor: Colors.red,
      //不生效！！
      disabledTextColor: Colors.blue,
      height: 48,
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
