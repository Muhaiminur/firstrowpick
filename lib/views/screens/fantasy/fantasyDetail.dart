import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/utils/colors.dart';

class FantasyDetailPage extends StatefulWidget {
  const FantasyDetailPage({super.key});

  @override
  State<FantasyDetailPage> createState() => _FantasyDetailPageState();
}

class _FantasyDetailPageState extends State<FantasyDetailPage> {
  String details = "";
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  void initState() {
    details = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          !themeController.isDarkMode.value ? Colors.white : Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color here
        ),
        backgroundColor: ProjectColors.secondaryColor,
        centerTitle: true,
        title: const Text(
          "Special",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                "SPECIAL",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(4),
              child: Html(data: details, style: {
                "body": Style(
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: FontSize(14.0),
                ),
              }),
            ),
          ],
        ),
      ),
    );
  }
}
