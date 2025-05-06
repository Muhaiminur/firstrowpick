import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/base_api_controller.dart';
import 'package:halftimepick/models/all_sports_model/sport.dart';

class HomeController extends BaseApiController {
  final Rx<ScrollController> scontroller = ScrollController().obs;

  Dio dio = Dio();
  List<Sport> gamename = [
    Sport(
      sportId: 1,
      sportName: "NCAA Football",
    ),
    Sport(sportId: 2, sportName: "NFL"),
    Sport(sportId: 3, sportName: "MLB"),
    Sport(sportId: 4, sportName: "NBA"),
    Sport(sportId: 5, sportName: "NCAA Men's Basketball"),
    Sport(sportId: 6, sportName: "NHL"),
    Sport(sportId: 8, sportName: "WNBA"),
    Sport(sportId: 10, sportName: "MLS"),
    Sport(sportId: 11, sportName: "EPL"),
    Sport(sportId: 14, sportName: "LALIGA"),
    Sport(sportId: 15, sportName: "SERIA A"),
    //TODO::commented out as of clients request
/*  
    Sport(sportId: 12, sportName: "LIGUE 1"),
    Sport(sportId: 13, sportName: "BUNDESLIGA"),

    Sport(sportId: 16, sportName: "UCL"),
    Sport(sportId: 17, sportName: "UEL"),
    Sport(sportId: 18, sportName: "FIFA"), */
  ];
}
