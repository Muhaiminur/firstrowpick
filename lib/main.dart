import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/views/screens/auth/edit_name.dart';
import 'package:halftimepick/views/screens/chatPages/mlbchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/nbachat.dart';
import 'package:halftimepick/views/screens/chatPages/ncaabchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/nflchat.dart';
import 'package:halftimepick/views/screens/chatPages/nhlchatpage.dart';
import 'package:halftimepick/views/screens/chatPages/mlschatpage.dart';
import 'package:halftimepick/views/screens/fantasy/fantasyDetail.dart';
import 'package:halftimepick/views/screens/games/games.dart';
import 'package:halftimepick/views/screens/home/homepage.dart';
import 'package:halftimepick/views/screens/landing/landingpage.dart';
import 'package:halftimepick/views/screens/livegame_page/live.dart';
import 'package:halftimepick/views/screens/news/newspage.dart';
import 'package:halftimepick/views/screens/news/newstile/newsdetailweb.dart';
import 'package:halftimepick/views/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(ThemeController(),
      permanent:
          true); // Ensure ThemeController is initialized before running the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: _buildTheme(Brightness.light),
        darkTheme: _buildTheme(Brightness.dark),
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (BuildContext context, Widget? child) {
          final mediaQueryData = MediaQuery.of(context);
          return MediaQuery(
            data:
                mediaQueryData.copyWith(textScaler: const TextScaler.linear(1)),
            child: child!,
          );
        },
        home: const Splash(),
        getPages: [
          GetPage(name: homePage, page: () => const HomePage()),
          GetPage(name: newsPage, page: () => const NewsPage()),
          GetPage(name: landingpage, page: () => const LandingPage()),
          GetPage(
              name: newsdetailwebview, page: () => const NewsDetailWebView()),
          GetPage(name: gamespage, page: () => const SpecificGamesPage()),
          GetPage(name: nflchatpage, page: () => const NFLChatPage()),
          GetPage(name: nbachatpage, page: () => const NBAChatPage()),
          GetPage(name: mlbchatpage, page: () => const MLBChatPage()),
          GetPage(name: nhlchatpage, page: () => const NHLChatPage()),
          GetPage(name: ncaafchatpage, page: () => const NCAABChatPage()),
          GetPage(name: ncaabchatpage, page: () => const NCAABChatPage()),
          GetPage(name: mlschatpage, page: () => const MLSChatPage()),
          GetPage(name: editprofile, page: () => const EditProfilePage()),
          GetPage(
              name: fantasyDetailPage, page: () => const FantasyDetailPage()),
          GetPage(name: livepage, page: () => const LiveGamePage()),
        ],
        debugShowCheckedModeBanner: false,
      );
    });
  }

  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(brightness: brightness);
    final textTheme = GoogleFonts.rubikTextTheme(baseTheme.textTheme);

    if (brightness == Brightness.light) {
      return baseTheme.copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: textTheme.copyWith(
          headlineMedium: const TextStyle(fontSize: 16.0, color: Colors.black),
          headlineLarge: const TextStyle(fontSize: 20.0, color: Colors.black),
          titleLarge:
              const TextStyle(fontSize: 24.0, color: ProjectColors.textBlack),
          titleMedium: const TextStyle(
              fontSize: 16.0,
              color: ProjectColors.textBlack,
              overflow: TextOverflow.ellipsis),
          titleSmall: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: ProjectColors.textBlack),
          bodySmall: const TextStyle(
              fontSize: 12.0,
              color: ProjectColors.textBlack,
              fontWeight: FontWeight.normal),
        ),
      );
    } else {
      return baseTheme.copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: textTheme.copyWith(
          headlineMedium: const TextStyle(fontSize: 16.0, color: Colors.white),
          headlineLarge: const TextStyle(fontSize: 20.0, color: Colors.white),
          titleLarge: const TextStyle(fontSize: 24.0, color: Colors.white),
          titleMedium: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              overflow: TextOverflow.ellipsis),
          titleSmall: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
          bodySmall: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.normal),
        ),
      );
    }
  }
}
