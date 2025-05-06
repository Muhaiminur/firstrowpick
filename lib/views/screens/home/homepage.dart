import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  final SplashController splashController = Get.find<SplashController>();
  final ThemeController themeController = Get.find<ThemeController>();
  List<String> images = [
    "5.png", //ncaaf
    "7.png", //nfl
    "mlb.png", //mlb
    "1.png", //nba
    "6.png", //ncaab
    "4.png", //nhl
    "2.png", //wnba
    "mls.png", //mls
    "epl.jpg",
    "laliga.jpg",
    "seriaa.png",
//TODO::commented out as of clients request
/*     
    "league1.png",
    "bundesliga.jpeg",
    "ucl.png",
    "uel.png",
    "wc.png" */
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<HomeController>(builder: (controller) {
          return controller.gamename.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.gamename.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (controller.gamename.elementAt(index).sportName! ==
                            "NCAA Football") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "NCAAF";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NFL") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "NFL";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "MLB") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "MLB";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NBA") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "NBA";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NCAA Men's Basketball") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "NCAAB";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NHL") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "NHL";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "EPL") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "EPL";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "LIGUE 1") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "LIGUE 1";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "BUNDESLIGA") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "BUNDESLIGA";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "LALIGA") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "LALIGA";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "SERIA A") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "SERIA A";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "UCL") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "UCL";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "UEL") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "UEL";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "FIFA") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "FIFA";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "WNBA") {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "WNBA";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        } else {
                          splashController.currentBottom.value = 0;
                          splashController.currentGame.value = "MLS";
                          splashController.update();
                          Get.offAllNamed(gamespage);
                        }
                      },
                      child: Container(
                        color: ProjectColors.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 54,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/${images.elementAt(index)}",
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.gamename
                                      .elementAt(index)
                                      .sportName!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  heightFactor: 4,
                  child: Text(
                    "NO GAME AVAILABLE",
                    style: !themeController.isDarkMode.value
                        ? const TextStyle(color: Colors.black, fontSize: 16)
                        : const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
        })
      ],
    );
  }
}
