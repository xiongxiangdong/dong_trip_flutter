import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final bool pwd;
  final String hit;
  final ValueChanged<String>? valueChanged;
  final TextInputType? textInputType;

  const InputWidget(this.hit,
      {super.key, this.pwd = false, this.valueChanged, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        const Divider(
          color: Colors.white,
          height: 1,
          thickness: 0.5,
        )
      ],
    );
  }

  _input() {
    return TextField(
      onChanged: valueChanged,
      obscureText: pwd,
      keyboardType: textInputType,
      autofocus: !pwd,
      cursorColor: Colors.white,
      style: const TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hit,
          hintStyle: const TextStyle(fontSize: 17, color: Colors.grey)),
    );
  }
}
