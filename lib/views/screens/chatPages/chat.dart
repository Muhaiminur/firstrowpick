import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/models/gameweekModel.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:halftimepick/views/screens/auth/login.dart';
import 'package:halftimepick/views/screens/chatPages/eplChat.dart';
import 'package:halftimepick/views/screens/chatPages/globalChat.dart';
import 'package:halftimepick/views/screens/chatPages/laligaChat.dart';
import 'package:halftimepick/views/screens/chatPages/mlbchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/nbachat.dart';
import 'package:halftimepick/views/screens/chatPages/ncaabchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/ncaafchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/nflchat.dart';
import 'package:halftimepick/views/screens/chatPages/nhlchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/mlschatpage.dart';
import 'package:halftimepick/views/screens/chatPages/seriaA.dart';
import 'package:halftimepick/views/screens/chatPages/wnbaChat.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final SplashController _splashController = Get.find<SplashController>();
  final EventController eventController = Get.put(EventController());
  List<GamesTab> games = [
    GamesTab("NFL", false),
    GamesTab("NBA", false),
    GamesTab("MLB", false),
    GamesTab("NHL", false),
    GamesTab("NCAAF", false),
    GamesTab("NCAAB", false),
    GamesTab("WNBA", false),
    GamesTab("MLS", false),
    GamesTab("EPL", false),
    GamesTab("LALIGA", false),
    GamesTab("SERIA A", false),
    //TODO::Commented out as per clients request
    /*  
    GamesTab("LIGUE 1", false),
    GamesTab("BUNDESLIGA", false),

    GamesTab("UCL", false),
    GamesTab("UEL", false),
    GamesTab("FIFA", false), */
  ];

  SharedPref sharedPref = SharedPref();

  List<String> userDetail = [];
  Future<List<String>> getUser() async {
    var userDel = await sharedPref.readStringList("userDet") ?? <String>[];
    setState(() {
      userDetail = userDel;
    });
    return userDetail;
  }

  @override
  void initState() {
    getUser().then((value) {
      games.first.isselected = true;
      _splashController.currentBottom.value = 3;
      _splashController.currentGame.value = "ALL";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userDetail.isNotEmpty
        ? Column(
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: double.infinity,
                height: 50,
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

                            print(
                                "vaL::" + _splashController.currentGame.value);
                            //changing

                            if (games.elementAt(index).name == "ALL") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "ALL";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "NFL") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "NFL";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "NBA") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "NBA";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "MLB") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "MLB";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "NHL") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "NHL";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "NCAAF") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "NCAAF";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "NCAAB") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "NCAAB";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "WNBA") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "WNBA";
                              _splashController.update();
                            } else if (games.elementAt(index).name == "EPL") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "EPL";
                              _splashController.update();
                            } else if (games.elementAt(index).name ==
                                "LALIGA") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "LALIGA";
                              _splashController.update();
                            } else if (games.elementAt(index).name ==
                                "SERIA A") {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "SERIA A";
                              _splashController.update();
                            } else {
                              _splashController.currentBottom.value = 3;
                              _splashController.currentGame.value = "MLS";
                              _splashController.update();
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: _splashController.currentGame.value == "ALL"
                      ? const GlobalChat()
                      : _splashController.currentGame.value == "NFL"
                          ? const NFLChatPage()
                          : _splashController.currentGame.value == "NBA"
                              ? const NBAChatPage()
                              : _splashController.currentGame.value == "MLB"
                                  ? const MLBChatPage()
                                  : _splashController.currentGame.value == "MLS"
                                      ? const MLSChatPage()
                                      : _splashController.currentGame.value ==
                                              "NCAAF"
                                          ? const NCAAFChatPage()
                                          : _splashController
                                                      .currentGame.value ==
                                                  "NCAAB"
                                              ? const NCAABChatPage()
                                              : _splashController
                                                          .currentGame.value ==
                                                      "WNBA"
                                                  ? const WnbaChatPage()
                                                  : _splashController
                                                              .currentGame
                                                              .value ==
                                                          "EPL"
                                                      ? const EplChatPage()
                                                      : _splashController
                                                                  .currentGame
                                                                  .value ==
                                                              "LALIGA"
                                                          ? const LaligaChatPage()
                                                          : _splashController
                                                                      .currentGame
                                                                      .value ==
                                                                  "SERIA A"
                                                              ? const SeriaAChatPage()
                                                              : const NHLChatPage()),
            ],
          )
        : const LoginPage();
  }
}
