import 'dart:async';
import 'dart:math';
import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/models/dashboard_models/reaction_test_model.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReactionTimeTestController extends BaseController {
  static String stateId = 'reaction_test_ui';

  Timer? timerFor3Minutes, timerWaitForGreen, timerGreen;

  bool isWaitForGreen = false;
  bool isGreen = false;

  List<ReactionTestModel> reactionTestList = [];

  var startTestTime = '';
  var startTimeForGreenCard = '';
  var tapTimeForGreenCard = '';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----ReactionTimeTestController---->');
      //    reactionTestModel = ReactionTestModel();
    });
  }

  void startTest() {
    var now = DateTime.now();
    startTestTime = now.toString();
    printf('---start-test-time---->$startTestTime');
    update([stateId]);
    timerFor3Minutes = Timer(const Duration(seconds: 40), () async {
      printf('---time-is-over---navigate-to-result-screen---->');
      printf('-----total--test--->${reactionTestList.length}');

      for (int i = 0; i < reactionTestList.length; i++) {
        printf(
            '-----start-time-->${reactionTestList[i].startTestTime} - start-green-time-->${reactionTestList[i].startTimeForGreenCard} - tap-green-time-->${reactionTestList[i].tapTimeForGreenCard} - is-tap-->${reactionTestList[i].isTap}');
      }

      stopAllTimer();
      Get.back();
    });
    showWaitForGreen();
  }

  void showWaitForGreen() {
    final random = Random();
    int randomSeconds = 2 + random.nextInt(5);

    printf('---random--second---->$randomSeconds');
    timerWaitForGreen = Timer(Duration(seconds: randomSeconds), () async {
      //printf('------show--green-card-now---->');
      showGreen();
    });

    isGreen = false;
    isWaitForGreen = true;
    update([stateId]);
  }

  void showGreen() {
    var now = DateTime.now();
    startTimeForGreenCard = now.toString();
    update([stateId]);

    timerGreen = Timer(const Duration(seconds: 10), () async {
      printf('<------attempt-fail----->');
      reactionTestList.add(ReactionTestModel(
          startTestTime: startTestTime,
          startTimeForGreenCard: startTimeForGreenCard,
          tapTimeForGreenCard: tapTimeForGreenCard,
          isTap: 'false'));
    });

    isWaitForGreen = false;
    isGreen = true;
    update([stateId]);
  }

  void clickOnGreen() {
    printf('<------save-time-and-show-wait-for-green----->');
    var now = DateTime.now();
    tapTimeForGreenCard = now.toString();
    update([stateId]);

    reactionTestList.add(ReactionTestModel(
        startTestTime: startTestTime,
        startTimeForGreenCard: startTimeForGreenCard,
        tapTimeForGreenCard: tapTimeForGreenCard,
        isTap: 'true'));

    timerGreen?.cancel();
    showWaitForGreen();
  }

  void stopAllTimer() {
    timerFor3Minutes?.cancel();
    timerWaitForGreen?.cancel();
    timerGreen?.cancel();
  }

  @override
  void dispose() {
    printf('<---dispose---and--stop--all-timers----->');
    stopAllTimer();
    super.dispose();
  }
}
