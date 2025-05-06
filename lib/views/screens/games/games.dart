import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/models/calendermodel.dart';
import 'package:halftimepick/services/gameList.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/dimensions.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:halftimepick/views/screens/games/epl/eplGamesList.dart';
import 'package:halftimepick/views/screens/games/laliga/laligaGamesList.dart';
import 'package:halftimepick/views/screens/games/nba/NbaGamesList.dart';
import 'package:halftimepick/views/screens/games/mlb/mlbGamesList.dart';
import 'package:halftimepick/views/screens/games/mls/mlsGamesList.dart';
import 'package:halftimepick/views/screens/games/ncaab/ncaabGamesList.dart';
import 'package:halftimepick/views/screens/games/ncaaf/ncaafGamesList.dart';
import 'package:halftimepick/views/screens/games/nfl/nflGamesList.dart';
import 'package:halftimepick/views/screens/games/nhl/nhlGamesList.dart';
import 'package:halftimepick/views/screens/games/seriaA/seriaAGamesList.dart';
import 'package:halftimepick/views/screens/games/wnba/wnbaGamesList.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SpecificGamesPage extends StatefulWidget {
  const SpecificGamesPage({super.key});

  @override
  State<SpecificGamesPage> createState() => _SpecificGamesPageState();
}

class _SpecificGamesPageState extends State<SpecificGamesPage> {
  String today = "";
  final ThemeController themeController = Get.find<ThemeController>();
  final SplashController _splashController = Get.find<SplashController>();
  final EventController eventController = Get.put(EventController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> gameKey = GlobalKey();

  SharedPref sharedPref = SharedPref();
  Timer? _timer;

  ScrollController scrollController = ScrollController();

  void scrollHandler() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              (scrollController.position.maxScrollExtent - 300) &&
          !scrollController.position.outOfRange) {
        if (!eventController.isLoading.value &&
            eventController.currentPage.value <
                eventController.lastPage.value) {
          eventController.startLoader();

          // Increment the page and fetch new data
          eventController.incrementPage();

          if (_splashController.currentGame.value == "NCAAF") {
            eventController.getNcaafEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "NFL") {
            eventController.getNflEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "MLB") {
            eventController.getMlbEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "NBA") {
            eventController.getNbaEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "NCAAB") {
            eventController.getNcaabEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "WNBA") {
            eventController.getWnbaEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "MLS") {
            eventController.getMlsEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "EPL") {
            eventController.getEplEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "LALIGA") {
            eventController.getLaligaEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else if (_splashController.currentGame.value == "SERIA A") {
            eventController.getSeriaAEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          } else {
            eventController.getNhlEvents().then((_) {
              eventController.stopLoader();
            }).catchError((error) {
              eventController.stopLoader();
            });
          }
        } else if (eventController.currentPage.value >=
            eventController.lastPage.value) {
          log("Already on the last page: ${eventController.lastPage.value}");
        }
      }
    });
  }

  currentGame() {
    games.forEach((element) {
      element.isselected = false;
    });
    games.forEach((element) {
      if (element.name.toLowerCase() ==
          _splashController.currentGame.value.toLowerCase()) {
        element.isselected = true;
      }
    });
  }

  List<CalenderModel> currentMonth = [];
  List<CalenderModel> calender() {
    DateTime now = DateTime.now().toLocal();
    currentMonth.clear();

    for (int i = 14; i > 0; i--) {
      DateTime day = now.subtract(Duration(days: i));
      final DateFormat formatter = DateFormat('MMM dd');
      final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
      final String formattedDate = formatter.format(day);
      final String apiFormattedDate = apiFormat.format(day);
      currentMonth.add(CalenderModel(formattedDate, apiFormattedDate, false));
    }

    final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
    final String apiFormattedDate = apiFormat.format(DateTime.now());
    currentMonth.add(CalenderModel("Today", apiFormattedDate, true));
    today = apiFormattedDate;
    eventController.date.value = apiFormattedDate;

    for (int i = 1; i <= 15; i++) {
      DateTime day = now.add(Duration(days: i));
      final DateFormat formatter = DateFormat('MMM dd');
      final String formattedDate = formatter.format(day);
      final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
      final String apiFormattedDate = apiFormat.format(day);

      currentMonth.add(CalenderModel(formattedDate, apiFormattedDate, false));
    }
    return currentMonth;
  }

  @override
  void initState() {
    initializeDateFormatting();
    currentGame();
    calender();
    if (_splashController.currentGame.value == "NCAAF") {
      eventController.ncaafEventloading.value = false;
      eventController.getNcaafEvents();
    } else if (_splashController.currentGame.value == "NFL") {
      eventController.nflEventloading.value = false;
      eventController.getNflEvents();
    } else if (_splashController.currentGame.value == "MLB") {
      eventController.mlbEventloading.value = false;
      eventController.getMlbEvents();
    } else if (_splashController.currentGame.value == "NBA") {
      eventController.nbaEventloading.value = false;
      eventController.getNbaEvents();
    } else if (_splashController.currentGame.value == "NCAAB") {
      eventController.ncaabEventloading.value = false;
      eventController.getNcaabEvents();
    } else if (_splashController.currentGame.value == "WNBA") {
      eventController.wnbaEventloading.value = false;
      eventController.getWnbaEvents();
    } else if (_splashController.currentGame.value == "MLS") {
      eventController.mlsEventloading.value = false;
      eventController.getMlsEvents();
    } else if (_splashController.currentGame.value == "EPL") {
      eventController.eplEventloading.value = false;
      eventController.getEplEvents();
    } else if (_splashController.currentGame.value == "LALIGA") {
      eventController.laligaEventloading.value = false;
      eventController.getLaligaEvents();
    } else if (_splashController.currentGame.value == "SERIA A") {
      eventController.seriaAEventloading.value = false;
      eventController.getSeriaAEvents();
    } else {
      eventController.nhlEventloading.value = false;
      eventController.getNhlEvents();
    }

    scrollHandler();

    _timer = Timer(const Duration(hours: 7), () {
      Get.offAllNamed(landingpage);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          !themeController.isDarkMode.value ? Colors.white : Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ProjectColors.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset("assets/images/logo.svg"),
            )
          ],
        ),
        centerTitle: false,
        titleSpacing: 0.0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: GetBuilder<EventController>(builder: (controller) {
          return Column(
            children: [
              Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                height: 60,
                child: ScrollablePositionedList.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: games.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: games.elementAt(index).isselected == true
                                ? ProjectColors.bottomnavselectedcolor
                                : Colors.black,
                            width: 3.0,
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            games.forEach((element) {
                              element.isselected = false;
                              games.elementAt(index).isselected = true;
                              _splashController.currentGame.value =
                                  games.elementAt(index).name;
                            });
                            currentMonth.forEach(
                              (element) {
                                element.isselected = false;
                              },
                            );
//to preselect current date in the calender when im changing the game
                            var todaysIndex = currentMonth.indexWhere(
                                (element) => element.date == "Today");
                            currentMonth.elementAt(todaysIndex).isselected =
                                true;
                            eventController.date.value = currentMonth
                                .elementAt(todaysIndex)
                                .apiFormattedDate;
                            eventController.currentPage.value = 1;

                            if (games.elementAt(index).name == "NFL") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "NFL";
                              _splashController.update();
                              eventController.nflEventloading.value = false;
                              eventController.update();
                              eventController.getNflEvents();
                            } else if (games.elementAt(index).name == "NBA") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "NBA";
                              _splashController.update();
                              eventController.nbaEventloading.value = false;
                              eventController.update();
                              eventController.getNbaEvents();
                            } else if (games.elementAt(index).name == "MLB") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "MLB";
                              _splashController.update();
                              eventController.mlbEventloading.value = false;
                              eventController.update();
                              eventController.getMlbEvents();
                            } else if (games.elementAt(index).name == "NHL") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "NHL";
                              _splashController.update();
                              eventController.nhlEventloading.value = false;
                              eventController.update();
                              eventController.getNhlEvents();
                            } else if (games.elementAt(index).name == "NCAAF") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "NCAAF";
                              _splashController.update();
                              eventController.ncaafEventloading.value = false;
                              eventController.update();
                              eventController.getNcaafEvents();
                            } else if (games.elementAt(index).name == "NCAAB") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "NCAAB";
                              _splashController.update();
                              eventController.ncaabEventloading.value = false;
                              eventController.update();
                              eventController.getNcaabEvents();
                            } else if (games.elementAt(index).name == "WNBA") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "WNBA";
                              _splashController.update();
                              eventController.wnbaEventloading.value = false;
                              eventController.update();
                              eventController.getWnbaEvents();
                            } else if (games.elementAt(index).name == "EPL") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "EPL";
                              _splashController.update();
                              eventController.eplEventloading.value = false;
                              eventController.update();
                              eventController.getEplEvents();
                            } else if (games.elementAt(index).name ==
                                "LALIGA") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "LALIGA";
                              _splashController.update();
                              eventController.laligaEventloading.value = false;
                              eventController.update();
                              eventController.getLaligaEvents();
                            } else if (games.elementAt(index).name ==
                                "SERIA A") {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "SERIA A";
                              _splashController.update();
                              eventController.seriaAEventloading.value = false;
                              eventController.update();
                              eventController.getSeriaAEvents();
                            } else {
                              _splashController.currentBottom.value = 0;
                              _splashController.currentGame.value = "MLS";
                              _splashController.update();
                              eventController.mlsEventloading.value = false;
                              eventController.update();
                              eventController.getMlsEvents();
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Text(
                            games.elementAt(index).name,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                color: games.elementAt(index).isselected == true
                                    ? ProjectColors.bottomnavselectedcolor
                                    : Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                height: 50,
                child: ScrollablePositionedList.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  initialScrollIndex: currentMonth
                          .indexWhere((element) => element.date == "Today") -
                      3,
                  itemCount: currentMonth.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        var a = currentMonth.indexWhere(
                            (element) => element.isselected == true);
                        setState(() {
                          eventController.currentPage.value = 1;
                          currentMonth.elementAt(a).isselected = false;
                          currentMonth.elementAt(index).isselected = true;
                        });
                        eventController.date.value =
                            currentMonth[index].apiFormattedDate;
                        if (_splashController.currentGame.value == "NCAAF") {
                          eventController.ncaafEventloading.value = false;

                          eventController.getNcaafEvents();
                        } else if (_splashController.currentGame.value ==
                            "NFL") {
                          eventController.nflEventloading.value = false;
                          eventController.getNflEvents();
                        } else if (_splashController.currentGame.value ==
                            "MLB") {
                          eventController.mlbEventloading.value = false;
                          eventController.getMlbEvents();
                        } else if (_splashController.currentGame.value ==
                            "NBA") {
                          eventController.nbaEventloading.value = false;
                          eventController.getNbaEvents();
                        } else if (_splashController.currentGame.value ==
                            "NCAAB") {
                          eventController.ncaabEventloading.value = false;
                          eventController.getNcaabEvents();
                        } else if (_splashController.currentGame.value ==
                            "MLS") {
                          eventController.mlsEventloading.value = false;
                          eventController.getMlsEvents();
                        } else if (_splashController.currentGame.value ==
                            "WNBA") {
                          eventController.wnbaEventloading.value = false;
                          eventController.getWnbaEvents();
                        } else if (_splashController.currentGame.value ==
                            "EPL") {
                          eventController.eplEventloading.value = false;
                          eventController.getEplEvents();
                        } else if (_splashController.currentGame.value ==
                            "LALIGA") {
                          eventController.laligaEventloading.value = false;
                          eventController.getLaligaEvents();
                        } else if (_splashController.currentGame.value ==
                            "SERIA A") {
                          eventController.seriaAEventloading.value = false;
                          eventController.getSeriaAEvents();
                        } else {
                          eventController.nhlEventloading.value = false;
                          eventController.getNhlEvents();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          child: Text(
                            currentMonth.elementAt(index).date,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                color: currentMonth[index].isselected == true
                                    ? Colors.blue
                                    : Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(
                (() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _splashController.currentGame.value == "NCAAB"
                            ? NcaabGamesList(themeController: themeController)
                            : _splashController.currentGame.value == "NBA"
                                ? NBAGamesList(themeController: themeController)
                                : _splashController.currentGame.value == "MLS"
                                    ? MlsGamesList(
                                        themeController: themeController)
                                    : _splashController.currentGame.value ==
                                            "WNBA"
                                        ? WnbaGamesList(
                                            themeController: themeController,
                                          )
                                        : _splashController.currentGame.value ==
                                                "MLB"
                                            ? MlbGamesList(
                                                themeController:
                                                    themeController)
                                            : _splashController.currentGame.value ==
                                                    "NFL"
                                                ? NflGamesList(
                                                    themeController:
                                                        themeController)
                                                : _splashController.currentGame
                                                            .value ==
                                                        "NCAAF"
                                                    ? NcaafGamesList(
                                                        themeController:
                                                            themeController,
                                                      )
                                                    : _splashController
                                                                .currentGame
                                                                .value ==
                                                            "EPL"
                                                        ? EplGamesList(
                                                            themeController:
                                                                themeController)
                                                        : _splashController
                                                                    .currentGame
                                                                    .value ==
                                                                "LALIGA"
                                                            ? LaligaGamesList(
                                                                themeController:
                                                                    themeController)
                                                            : _splashController
                                                                        .currentGame
                                                                        .value ==
                                                                    "SERIA A"
                                                                ? SeriaAGamesList(
                                                                    themeController:
                                                                        themeController)
                                                                : NhlGamesList(
                                                                    themeController:
                                                                        themeController),
                        eventController.isLoading.value
                            ? Center(
                                heightFactor: 3,
                                child: CupertinoActivityIndicator(
                                    color: themeController.isDarkMode.value
                                        ? Colors.white
                                        : Colors.grey),
                              )
                            : const SizedBox.shrink()
                      ],
                    )),
              )
            ],
          );
        }),
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
          builder: (controller) => Obx(() => BottomNavigationBar(
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: ProjectColors.primaryColor,
                selectedItemColor: ProjectColors.bottomnavselectedcolor,
                unselectedItemColor: ProjectColors.grey,
                selectedFontSize: 8,
                unselectedFontSize: 8,
                currentIndex: _splashController.currentBottom.value,
                onTap: (value) {
                  setState(() {
                    _splashController.currentBottom.value = value;
                    _splashController.update();
                    if (kDebugMode) {
                      log(_splashController.currentBottom.value.toString());
                    }
                    Get.offAllNamed(landingpage);
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    activeIcon: SvgPicture.asset(
                      "assets/images/homeactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/homeicon.svg",
                      height: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "News",
                    activeIcon: SvgPicture.asset(
                      "assets/images/newsactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/newsicon.svg",
                      height: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Home",
                    activeIcon: SvgPicture.asset(
                      "assets/images/homeactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/homeicon.svg",
                      height: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Chat",
                    activeIcon: SvgPicture.asset(
                      "assets/images/pickactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/pickicon.svg",
                      height: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Special",
                    activeIcon: SvgPicture.asset(
                      "assets/images/fantasy.svg",
                      color: ProjectColors.bottomnavselectedcolor,
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/fantasy.svg",
                      height: 20,
                    ),
                  ),
                ],
              ))),
    );
  }
}
