import 'package:flutter/material.dart';

class LoginWidget2 extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String title;
  final bool enable;

  const LoginWidget2(this.title,
      {super.key, this.enable = true, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return _getBtn();
  }

  _getBtn() {
    return MaterialButton(
      color: Colors.orange,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: enable ? voidCallback : null,
      disabledColor: Colors.white60,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
