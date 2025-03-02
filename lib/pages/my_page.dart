import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/common_webview.dart';

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
      body: const CommonWebView(
        url: 'https://pub.dev/packages/flutter_hi_cache',
        hideAppBar: true,
        hideBack: true,
      ),
    );
  }
}
