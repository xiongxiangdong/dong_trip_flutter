import 'package:flutter/material.dart';

class InputWidget2 extends StatelessWidget {
  final String hit;
  final bool pwd;
  final TextInputType? textInputType;
  final ValueChanged<String>? valueChanged;

  const InputWidget2(this.hit,
      {super.key, this.pwd = false, this.textInputType, this.valueChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getInput(),
        const Divider(
          thickness: 0.5,
          height: 1,
          color: Colors.white,
        )
      ],
    );
  }

  _getInput() {
    return TextField(
      autofocus: !pwd,
      obscureText: pwd,
      onChanged: valueChanged,
      keyboardType: textInputType,
      style: const TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hit,
          hintStyle: const TextStyle(
              fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w400)),
    );
  }
}
