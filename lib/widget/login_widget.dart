import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final String name;
  final bool enableLogin;
  final VoidCallback? callback;

  const LoginWidget(this.name,
      {super.key, required this.enableLogin, required this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      color: Colors.orange,
      disabledColor: Colors.white60,
      onPressed: enableLogin ? callback : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
