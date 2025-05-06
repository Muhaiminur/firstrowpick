import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/base_api_controller.dart';
import 'package:halftimepick/models/epl_model/datum.dart';
import 'package:halftimepick/models/epl_model/epl_model.dart';
import 'package:halftimepick/models/fantasy_model/fantasy_model.dart';
import 'package:halftimepick/models/laliga_model/datum.dart';
import 'package:halftimepick/models/laliga_model/laliga_model.dart';
import 'package:halftimepick/models/mlb_game/datum.dart';
import 'package:halftimepick/models/mlb_game/mlb_game.dart';
import 'package:halftimepick/models/mls_model/datum.dart';
import 'package:halftimepick/models/mls_model/mls_model.dart';
import 'package:halftimepick/models/nba_games/datum.dart';
import 'package:halftimepick/models/nba_games/nba_games.dart';
import 'package:halftimepick/models/ncaab_games/datum.dart';
import 'package:halftimepick/models/ncaab_games/ncaab_games.dart';
import 'package:halftimepick/models/ncaaf_games/datum.dart';
import 'package:halftimepick/models/ncaaf_games/ncaaf_games.dart';
import 'package:halftimepick/models/news_nhl/news.dart';
import 'package:halftimepick/models/nfl_game/datum.dart';
import 'package:halftimepick/models/nfl_game/nfl_game.dart';
import 'package:halftimepick/models/nhl_games/datum.dart';
import 'package:halftimepick/models/nhl_games/nhl_games.dart';
import 'package:halftimepick/models/seria_a_model/datum.dart';
import 'package:halftimepick/models/seria_a_model/seria_a_model.dart';
import 'package:halftimepick/models/wnba_games/datum.dart';
import 'package:halftimepick/models/wnba_games/wnba_games.dart';

class EventController extends BaseApiController {
  final Rx<ScrollController> scontroller = ScrollController().obs;

  RxList<nhlLNewsList> nhlnewslist = <nhlLNewsList>[].obs;
  //sports id: 1 ncaaf
  RxBool ncaafEventloading = false.obs;
  Rx<NcaafGames> ncaafGame = NcaafGames().obs;
  RxList<NcaafGamesData> ncaafgamedata = <NcaafGamesData>[].obs;
  //sports id: 2 nfl
  RxBool nflEventloading = false.obs;
  Rx<NflGame> nflGame = NflGame().obs;
  RxList<NflGameData> nflgamedata = <NflGameData>[].obs;
  //sports id: 3 mlb
  RxBool mlbEventloading = false.obs;
  Rx<MlbGame> mlbGame = MlbGame().obs;
  RxList<MlbGameData> mlbgamedata = <MlbGameData>[].obs;
  //sports id: 4 nba
  RxBool nbaEventloading = false.obs;
  Rx<NbaGames> nbaGame = NbaGames().obs;
  RxList<NbaGamesData> nbagamedata = <NbaGamesData>[].obs;
  //sports id: 5 ncaab
  RxBool ncaabEventloading = false.obs;
  Rx<NcaabGames> ncaabGame = NcaabGames().obs;
  RxList<NcaabGamesData> ncaabgamedata = <NcaabGamesData>[].obs;

  //sports id: 6 nhl
  RxBool nhlEventloading = false.obs;
  Rx<NhlGames> nhlGame = NhlGames().obs;
  RxList<NhlGamesData> nhlgamedata = <NhlGamesData>[].obs;

  //sports id: 8 wnba
  RxBool wnbaEventloading = false.obs;
  Rx<WnbaGames> wnbaGame = WnbaGames().obs;
  RxList<WnbaGamesData> wnbagamedata = <WnbaGamesData>[].obs;

  //sports id: 10 mls
  RxBool mlsEventloading = false.obs;
  Rx<MlsModel> mlsGame = MlsModel().obs;
  RxList<MlsGameData> mlsgamedata = <MlsGameData>[].obs;

  //sports id: 11 epl
  RxBool eplEventloading = false.obs;
  Rx<EplModel> eplGame = EplModel().obs;
  RxList<EplModelData> eplgamedata = <EplModelData>[].obs;

  //sports id: 14 laliga
  RxBool laligaEventloading = false.obs;
  Rx<LaligaModel> laligaGame = LaligaModel().obs;
  RxList<LaligaModelData> laligagamedata = <LaligaModelData>[].obs;

  //sports id: 15 seriaa
  RxBool seriaAEventloading = false.obs;
  Rx<SeriaAModel> seriaAGame = SeriaAModel().obs;
  RxList<SeriaAModelData> seriaAgamedata = <SeriaAModelData>[].obs;

  Rx<FantasyModel> fantasyModel = FantasyModel().obs;
  RxBool fantasyModelloading = false.obs;

  RxString date = "".obs;

  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var isLoading = false.obs;

  // Method to increment the current page
  void incrementPage() {
    if (currentPage.value < lastPage.value) {
      currentPage.value++;
      update();
    }
  }

  // Method to start the loader
  void startLoader() {
    isLoading.value = true;
    update();
  }

  // Method to stop the loader
  void stopLoader() {
    isLoading.value = false;
    update();
  }

  Future<List<NcaafGamesData>> getNcaafEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("1/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      NcaafGames ncaaf = NcaafGames.fromJson(response.data);
      currentPage.value = ncaaf.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort the fetched data by eventDate in ascending order
      List<NcaafGamesData> sortedData = ncaaf.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        ncaafgamedata.value = sortedData;
      } else {
        ncaafgamedata.addAll(sortedData);
      }

      lastPage.value = ncaaf.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      ncaafEventloading.value = true;
      update();
      return ncaafgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NcaafGamesData>[];
    }
  }

// game id : 3 mlb
  Future<List<MlbGameData>> getMlbEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("3/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      MlbGame mlb = MlbGame.fromJson(response.data);
      currentPage.value = mlb.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<MlbGameData> sortedData = mlb.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        mlbgamedata.value = sortedData;
      } else {
        mlbgamedata.addAll(sortedData);
      }

      lastPage.value = mlb.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      mlbEventloading.value = true;
      update();
      return mlbgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <MlbGameData>[];
    }
  }

// game id : 4 nba
  Future<List<NbaGamesData>> getNbaEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("4/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      NbaGames nba = NbaGames.fromJson(response.data);
      currentPage.value = nba.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<NbaGamesData> sortedData = nba.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        nbagamedata.value = sortedData;
      } else {
        nbagamedata.addAll(sortedData);
      }

      lastPage.value = nba.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      nbaEventloading.value = true;
      update();
      return nbagamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NbaGamesData>[];
    }
  }

// game id : 6 nhl
  Future<List<NhlGamesData>> getNhlEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("6/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      NhlGames nhl = NhlGames.fromJson(response.data);
      currentPage.value = nhl.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<NhlGamesData> sortedData = nhl.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        nhlgamedata.value = sortedData;
      } else {
        nhlgamedata.addAll(sortedData);
      }

      lastPage.value = nhl.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      nhlEventloading.value = true;
      update();
      return nhlgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NhlGamesData>[];
    }
  }

// game id : 2 nfl
  Future<List<NflGameData>> getNflEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("2/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      NflGame nfl = NflGame.fromJson(response.data);
      currentPage.value = nfl.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<NflGameData> sortedData = nfl.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        nflgamedata.value = sortedData;
      } else {
        nflgamedata.addAll(sortedData);
      }

      lastPage.value = nfl.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      nflEventloading.value = true;
      update();
      return nflgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NflGameData>[];
    }
  }

// game id : 5 ncaab
  Future<List<NcaabGamesData>> getNcaabEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("5/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      NcaabGames ncaab = NcaabGames.fromJson(response.data);
      currentPage.value = ncaab.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<NcaabGamesData> sortedData = ncaab.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        ncaabgamedata.value = sortedData;
      } else {
        ncaabgamedata.addAll(sortedData);
      }

      lastPage.value = ncaab.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      ncaabEventloading.value = true;
      update();
      return ncaabgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NcaabGamesData>[];
    }
  }

// game id : 8 wnba
  Future<List<WnbaGamesData>> getWnbaEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("8/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      WnbaGames wnba = WnbaGames.fromJson(response.data);
      currentPage.value = wnba.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<WnbaGamesData> sortedData = wnba.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        wnbagamedata.value = sortedData;
      } else {
        wnbagamedata.addAll(sortedData);
      }

      lastPage.value = wnba.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      wnbaEventloading.value = true;
      update();
      return wnbagamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <WnbaGamesData>[];
    }
  }

// game id : 10 mls
  Future<List<MlsGameData>> getMlsEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("10/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      MlsModel mls = MlsModel.fromJson(response.data);
      currentPage.value = mls.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<MlsGameData> sortedData = mls.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        mlsgamedata.value = sortedData;
      } else {
        mlsgamedata.addAll(sortedData);
      }

      lastPage.value = mls.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      mlsEventloading.value = true;
      update();
      return mlsgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <MlsGameData>[];
    }
  }

// game id : 11 epl
  Future<List<EplModelData>> getEplEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("11/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      EplModel epl = EplModel.fromJson(response.data);
      currentPage.value = epl.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<EplModelData> sortedData = epl.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        eplgamedata.value = sortedData;
      } else {
        eplgamedata.addAll(sortedData);
      }

      lastPage.value = epl.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      eplEventloading.value = true;
      update();
      return eplgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <EplModelData>[];
    }
  }

// game id : 14 laliga
  Future<List<LaligaModelData>> getLaligaEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("14/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      LaligaModel laliga = LaligaModel.fromJson(response.data);
      currentPage.value = laliga.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<LaligaModelData> sortedData = laliga.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        laligagamedata.value = sortedData;
      } else {
        laligagamedata.addAll(sortedData);
      }

      lastPage.value = laliga.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      laligaEventloading.value = true;
      update();
      return laligagamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <LaligaModelData>[];
    }
  }

// game id : 15 seriaa
  Future<List<SeriaAModelData>> getSeriaAEvents() async {
    log(date.value);
    try {
      var response = await getDio()!.get("15/events/${date.value}",
          queryParameters: {"page": currentPage.value});
      SeriaAModel seriaa = SeriaAModel.fromJson(response.data);
      currentPage.value = seriaa.meta!.currentPage!;
      log("currentPage:${currentPage.value}");

      // Sort data by eventDate in descending order
      List<SeriaAModelData> sortedData = seriaa.data!
        ..sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

      if (currentPage.value == 1) {
        seriaAgamedata.value = sortedData;
      } else {
        seriaAgamedata.addAll(sortedData);
      }

      lastPage.value = seriaa.meta!.lastPage!;
      log("lastPage:${lastPage.value}");
      seriaAEventloading.value = true;
      update();
      return seriaAgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <SeriaAModelData>[];
    }
  }

  //fantasy list
  Future<FantasyModel> getFantasyList() async {
    fantasyModelloading.value = false;
    update();
    try {
      var response = await getDio()!.get(
        "posts",
      );
      FantasyModel model = FantasyModel.fromJson(response.data);
      fantasyModel.value = model;
      fantasyModelloading.value = true;
      update();
      return fantasyModel.value;
    } on DioError catch (e) {
      Get.snackbar("Error", e.response!.statusCode!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return FantasyModel();
    }
  }
}
