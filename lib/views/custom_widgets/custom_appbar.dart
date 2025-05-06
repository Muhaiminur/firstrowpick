import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/dimensions.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  final bool search;
  final bool logo;

  const CustomAppBar({
    Key? key,
    required this.scaffoldkey,
    required this.search,
    required this.logo,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final SplashController splashController = Get.find<SplashController>();
  final ThemeController themeController =
      Get.find<ThemeController>(); // Ensure correct initialization
  String gamename = "";
  SharedPref sharedPref = SharedPref();
  List<String> userDetail = [];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<List<String>> getUser() async {
    var userDel = await sharedPref.readStringList("userDet") ?? <String>[];
    print(userDel);
    setState(() {
      userDetail = userDel;
    });

    return userDetail;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (controller) {
      return AppBar(
        elevation: 0.0,
        backgroundColor: ProjectColors.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: controller.currentBottom.value == 3
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (controller.currentBottom.value == 0 ||
                controller.currentBottom.value == 1 ||
                controller.currentBottom.value == 2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset("assets/images/logo.svg"),
              ),
            if (!widget.logo)
              Obx(
                () => Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: controller.currentBottom.value == 3
                      ? const Text("CHAT")
                      : null,
                ),
              ),
          ],
        ),
        centerTitle: true,
        titleSpacing: 0.0,
        actions: [
          if (controller.currentBottom.value == 0)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Obx(() {
                return ToggleSwitch(
                  minWidth: 40.0,
                  minHeight: 30.0,
                  initialLabelIndex: themeController.isDarkMode.value ? 0 : 1,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: const [
                    FontAwesomeIcons.moon,
                    FontAwesomeIcons.sun,
                  ],
                  iconSize: 30.0,
                  activeBgColors: const [
                    [
                      ProjectColors.bottomnavselectedcolor,
                      ProjectColors.homeswitch
                    ],
                    [Colors.amber, Colors.orange],
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    themeController.toggleTheme(index == 0);
                    print('Switched to: $index');
                  },
                );
              }),
            ),
          if (controller.currentBottom.value == 3 && userDetail.isNotEmpty)
            IconButton(
              onPressed: () {
                Get.offNamed(editprofile);
              },
              icon: const Icon(
                Icons.edit,
                size: 18,
              ),
            ),
        ],
      );
    });
  }
}
