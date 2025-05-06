import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveGamePage extends StatefulWidget {
  const LiveGamePage({super.key});

  @override
  State<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends State<LiveGamePage> {
  final GlobalKey<ScaffoldState> newsdetailkey = GlobalKey();
  final ThemeController themeController = Get.find<ThemeController>();
  late WebViewController controller;
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
      ..loadRequest(Uri.parse("https://reddit1.nflbite.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          !themeController.isDarkMode.value ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: ProjectColors.secondaryColor,
        title: const Text(
          "Live Game",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: loaded
          ? WebViewWidget(controller: controller)
          : Center(
              heightFactor: 4,
              child: CupertinoActivityIndicator(
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.grey),
            ),
    );
  }
}
