import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:halftimepick/views/custom_widgets/custom_appbar.dart';
import 'package:halftimepick/views/screens/auth/login.dart';
import 'package:halftimepick/views/screens/chatPages/chat.dart';
import 'package:halftimepick/views/screens/fantasy/fantasylist.dart';
import 'package:halftimepick/views/screens/home/homepage.dart';
import 'package:halftimepick/views/screens/news/newspage.dart';
import 'package:halftimepick/views/screens/webViewBottom/websiteView.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final SplashController _splashController = Get.find<SplashController>();
  final HomeController _homeController = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _landingKey = GlobalKey();
  SharedPref sharedPref = SharedPref();
  bool dialogOpen = false;
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
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const NewsPage(),
    const WebsiteView(),
    const ChatPage(),
    const FantasyList()
  ];
  final List<Widget> _widgetOptions2 = <Widget>[
    const HomePage(),
    const NewsPage(),
    const WebsiteView(),
    const LoginPage(),
    const FantasyList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        scaffoldkey: _landingKey,
        search: false,
        logo: false,
      ),
      body: GetBuilder<HomeController>(builder: ((controller) {
        return SingleChildScrollView(
            controller: _homeController.scontroller.value,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: GetBuilder<HomeController>(builder: (controller) {
              return Obx(() {
                return userDetail.isNotEmpty
                    ? _widgetOptions
                        .elementAt(_splashController.currentBottom.value)
                    : _widgetOptions2
                        .elementAt(_splashController.currentBottom.value);
              });
            }));
      })),
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
                      "assets/images/chat.svg",
                      color: ProjectColors.bottomnavselectedcolor,
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/chat.svg",
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
