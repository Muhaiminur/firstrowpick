import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/views/screens/games/nhl/nhlScoreItem.dart';

class NhlGamesList extends StatelessWidget {
  const NhlGamesList({
    super.key,
    required this.themeController,
  });

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(builder: (controller) {
      return controller.nhlEventloading.value
          ? controller.nhlgamedata.isNotEmpty
              ? ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return NhlScoreItem(
                      item: controller.nhlgamedata.elementAt(index),
                    );
                  },
                  itemCount: controller.nhlgamedata.length,
                )
              : Center(
                  heightFactor: 3,
                  child: Text(
                    "Please Check SPECIAL",
                    style: TextStyle(
                        fontSize: 18,
                        color: themeController.isDarkMode.value
                            ? Colors.white
                            : Colors.black),
                  ),
                )
          : Center(
              heightFactor: 3,
              child: CupertinoActivityIndicator(
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.grey),
            );
    });
  }
}
