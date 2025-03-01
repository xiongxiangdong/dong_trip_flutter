import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navigator_util2.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  const CommonWebView(
      {super.key,
      this.url,
      this.title,
      required this.hideBack,
      required this.hideAppBar,
      this.statusBarColor,
      this.backForbid});

  final String? url;
  final String? title;
  final bool hideBack;
  final bool hideAppBar;
  final bool? backForbid; //禁止返回
  final String? statusBarColor;

  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  final _catchUrl = ["", "", ""];
  String? url;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('')) {
      url = url!.replaceAll('http://', "https://");
    }
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            //页面加载完成才能执行js
            _handleBackForbid();
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            //阻止跳转
            if (goMain(request.url)) {
              NavigatorUtil2.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url!));
  }

  bool goMain(String? url) {
    bool contain = false;
    for (var item in _catchUrl) {
      if (url?.endsWith(item) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  //处理返回widget
  void _handleBackForbid() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
