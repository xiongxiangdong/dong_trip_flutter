import 'package:flutter/material.dart';

class InputWidget3 extends StatelessWidget {
  const InputWidget3(this.hit,
      {super.key, this.pwd = false, this.valueChanged, this.textInputType});

  final String hit;
  final bool pwd;
  final ValueChanged<String>? valueChanged;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          cursorColor: Colors.white,
          obscureText: pwd,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hit,
              hintStyle: const TextStyle(color: Colors.grey)),
          autofocus: !pwd,
          onChanged: valueChanged,
          keyboardType: textInputType,
        ),
        const Divider(
          height: 0.5,
          thickness: 1,
          color: Colors.white,
        )
      ],
    );
  }
}
