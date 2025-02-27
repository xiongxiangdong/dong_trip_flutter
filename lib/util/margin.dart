import 'package:flutter/material.dart';

SizedBox getMargin({double width = 1, double height = 1}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

Widget getShadow({EdgeInsetsGeometry? padding, required Widget child}) {
  return Container(
    padding: padding,
    decoration: const BoxDecoration(
        //AppBar渐变
        gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    child: child,
  );
}
