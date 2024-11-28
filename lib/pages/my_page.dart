import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mine"),
      ),
      body: const Column(
        children: [Text("MyPage")],
      ),
    );
  }
}
