import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navigator_util2.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * FractionallySizedBox
 * Positioned
 *
 * https://pub.dev/
 * License(许可证) MIT/ BSD / Apache2.0
 */
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
    String appBarColor = widget.statusBarColor ?? "ffffff";
    Color backBtnColor;
    if (appBarColor == "ffffff") {
      backBtnColor = Colors.black;
    } else {
      backBtnColor = Colors.white;
    }
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (await controller.canGoBack()) {
            controller.goBack();
          } else {
            //避免内存泄露
            if (context.mounted) {
              NavigatorUtil2.pop(context);
            }
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              _appBar(Color(int.parse('0xff$appBarColor')), backBtnColor),
              Expanded(child: _content(context)),
            ],
          ),
        ));
  }

  Widget _appBar(Color bgColor, Color backBtnColor) {
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideBack) {
      return Container(
        padding: EdgeInsets.only(top: top),
        height: top,
      );
    }
    return Container(
      color: bgColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            _backBtn(bgColor),
            _title(bgColor),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return WebViewWidget(controller: controller);
  }

  Widget _backBtn(Color bgColor) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Icon(
          Icons.close,
          size: 10,
          color: bgColor,
        ),
      ),
    );
  }

  Widget _title(Color bgColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          widget.title ?? "",
          style: TextStyle(color: bgColor, fontSize: 14),
        ),
      ),
    );
  }
}
