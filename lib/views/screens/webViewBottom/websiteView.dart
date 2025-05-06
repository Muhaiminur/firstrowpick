import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsiteView extends StatefulWidget {
  const WebsiteView({super.key});

  @override
  State<WebsiteView> createState() => _WebsiteViewState();
}

class _WebsiteViewState extends State<WebsiteView> {
  final ThemeController themeController = Get.find<ThemeController>();
  late WebViewController controller;
  var url = "https://firstrowpick.com/";
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress.toString());
            if (progress == 100) {
              setState(() {
                loaded = true;
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    const double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenHeightWithoutAppBarAndBottomNavigationBar =
        screenHeight - bottomNavigationBarHeight;
    return loaded
        ? SizedBox(
            height: screenHeightWithoutAppBarAndBottomNavigationBar,
            child: WebViewWidget(controller: controller))
        : Center(
            heightFactor: 4,
            child: CupertinoActivityIndicator(
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.grey),
          );
  }
}
