import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/models/dashboard_models/reaction_test_model.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReactionTimeTestController extends BaseController {
  static String stateId = 'reaction_test_ui';

  Timer? timerFor3Minutes, timerWaitForGreen, timerGreen;

  bool isWaitForGreen = false;
  bool isGreen = false;
  bool isResult = false;

  List<ReactionTest> reactionTestList = [];

  List<ReactionTest> reactionTestListFilter = [];

  List<int> listOfDifference = [];

  List<int> listForFalseStarts = [];
  List<int> listForValidStimuli = [];

  List<int> listForPlusLapsesCount = [];

  var userId = '';
  var startTestTime = '';
  var startTimeForGreenCard = '';
  var tapTimeForGreenCard = '';
  var fastest = '0';
  var slowest = '0';
  var average = '0';

  int total = 0;
  double avg = 0;

  int totalSqrt = 0;
  List<int> listForSqrt = [];

  List<GraphModel> listForGraph = [];

  var speed = '0';
  var falseStart = '0';
  var accuracy = '0';
  var variation = '0';
  var plusLapses = '0';

  late ReactionTestModel reactionTestModel;

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.reactionTestTable);

  int randomTime = 0;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----ReactionTimeTestController---->');
      reactionTestModel = ReactionTestModel();
      getUserId();
      //var now = DateTime.now().millisecondsSinceEpoch;
      //printf('---milliseconds----->$now');
    });
  }

  @override
  void dispose() {
    printf('<---dispose---and--stop--all-timers----->');
    stopAllTimer();
    super.dispose();
  }

  void getUserId() async {
    printf('<---get_user-id----->');
    try {
      userId = await Utility.getUserId();
      printf('<--user-id------->$userId');
      update([stateId]);
    } catch (exe) {
      printf('<---exe-user-id--->$exe');
    }
  }

  void startTest() {
    var now = DateTime.now();
    startTestTime = now.toString();
    //printf('---start-test-time---->$startTestTime');
    update([stateId]); // 180000
    timerFor3Minutes = Timer(const Duration(milliseconds: 30000), () async {
      //printf('---time-is-over---navigate-to-result-screen---->');
      printf('-----total--attempt--->${reactionTestList.length}');
      //printf('---total--true-attempt------>${reactionTestListFilter.length}');

      isResult = true;
      for (int i = 0; i < reactionTestList.length; i++) {
        if (reactionTestList[i].isTap != 'false') {
          reactionTestListFilter.add(reactionTestList[i]);
        }
      }
      printf(
          '<-------------------------------------------------------------------->');

      for (int i = 0; i < reactionTestListFilter.length; i++) {
        int diff = int.parse(
                reactionTestListFilter[i].tapTimeForGreenCard.toString()) -
            int.parse(
                reactionTestListFilter[i].startTimeForGreenCard.toString());

        total = total + diff;
        listOfDifference.add(diff);

        int? randomTime = reactionTestListFilter[i].randomTime;

        listForGraph.add(GraphModel(randomTime.toString(), diff));

        if (diff >= 355) {
          listForPlusLapsesCount.add(1);
        } else if (diff < 100) {
          listForFalseStarts.add(1);
        } else if (diff >= 100 && diff < 355) {
          listForValidStimuli.add(1);
        }

        printf(
            '----difference-for-time-test---->$diff---random-time-->${reactionTestListFilter[i].randomTime}');
      }
      printf(
          '<-------------------------------------------------------------------->');
      printf('----total-graph-list--->${listForGraph.length}');
      printf(
          '----total--for-lapses-count----->${listForPlusLapsesCount.length}');
      printf('----total--for-false-count----->${listForFalseStarts.length}');
      printf(
          '----total-for-valid-stimuli-count----->${listForValidStimuli.length}');
      printf(
          '<-------------------------------------------------------------------->');

      // for (int i = 0; i < listForGraph.length; i++) {
      //   printf('--time--->${listForGraph[i].title}----->${listForGraph[i].value}');
      // }

      if (listOfDifference.isNotEmpty) {
        int l = findHighest(list: listOfDifference);
        slowest = l.toString();

        int f = findLowest(list: listOfDifference);
        fastest = f.toString();

        avg = total / listOfDifference.length;

        average = avg.toInt().toString();

        double sp = 1000 / avg;

        speed = sp.toDouble().toStringAsFixed(4).toString();

        falseStart = listForFalseStarts.length.toString();

        update([stateId]);
        //printf('---lowest--->$slowest----fastest-->$fastest---avg-->$average---speed-->$sp');
      }
      printf(
          '<-------------------------------------------------------------------->');
      for (int i = 0; i < reactionTestListFilter.length; i++) {
        int diff = int.parse(
                reactionTestListFilter[i].tapTimeForGreenCard.toString()) -
            int.parse(
                reactionTestListFilter[i].startTimeForGreenCard.toString());

        final meanDiff = (diff - avg).toInt();

        int squareValue = meanDiff * meanDiff;

        //printf('--------difference-for-square--->$meanDiff---->$squareValue');

        totalSqrt = totalSqrt + squareValue.toInt();

        listOfDifference.add(diff);
      }
      printf(
          '<-------------------------------------------------------------------->');

      //printf('----total-for-square-value---->$totalSqrt');

      int variance = totalSqrt ~/ reactionTestListFilter.length;

      //printf('----total-for-square-value---->$totalSqrt---variance--->$variance');

      double stdDeviation = sqrt(variance);

      //printf('----final-stdDeviation------>$stdDeviation');

      double finalVariation = (stdDeviation / avg) * 100;

      //printf('-----finalVariation------>$finalVariation');

      //final ps = 100 % -[(listForPlusLapsesCount.length + listForFalseStarts.length) / (listForValidStimuli.length + listForFalseStarts.length)] * 100;
      // final ps = 100
      //     -((listForPlusLapsesCount.length + listForFalseStarts.length) /
      //         (listForValidStimuli.length + listForFalseStarts.length)) *
      //     100;

      final ps = (listForValidStimuli.length + listForFalseStarts.length) *
          100 /
          reactionTestListFilter.length;

      plusLapses = listForPlusLapsesCount.length.toString();
      accuracy = ps.roundToDouble().toString();

      variation = finalVariation.toDouble().toStringAsFixed(2);

      printf('----performance-score---->$ps');

      stopAllTimer();
      //Get.back();
    });
    showWaitForGreen();
  }

  void buttonSave() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MMM-yyyy');
    String formattedDate = formatter.format(now);

    var formatterMonth = DateFormat('MMM, yyyy');
    reactionTestModel.userId = userId;
    reactionTestModel.dateTime = formattedDate;
    reactionTestModel.monthYear = formatterMonth.format(now);
    reactionTestModel.reactionTestTime = '${now.hour}:${now.minute}:${now.second}';
    reactionTestModel.average = average;
    reactionTestModel.fastest = fastest;
    reactionTestModel.slowest = slowest;
    reactionTestModel.speed = speed;
    reactionTestModel.falseStart = falseStart;
    reactionTestModel.accuracy = accuracy;
    reactionTestModel.variation = variation;
    reactionTestModel.plusLapses = plusLapses;
    now = DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);
    reactionTestModel.timeStamp = now.millisecondsSinceEpoch;
    reactionTestModel.reactionTest = reactionTestListFilter;

    //printf('reactionTimeTest-Json--->${reactionTestModel.toMap()}');

    printf(
        'reactionTimeTest-Json--->${jsonEncode(reactionTestModel.toJson())}');

    //
    Utility.isConnected().then((isInternet) async {
      if (isInternet) {
        try {
          loaderShow();
          databaseReference.ref
              .child(userId.toString())
              .push()
              .set(reactionTestModel.toJson())
              .whenComplete(() async {
            printf('<---------record--added-to-firebase------------>');
            Utility().snackBarSuccess(AppStrings.testAddedSuccessFully);
            Get.back();
            loaderHide();
          }).onError((error, stackTrace) async {
            printf('--please-try-again-later---');
          });
        } catch (e) {
          printf('<----exe---reaction-time-test---121->$e');
          loaderHide();
        }
      } else {
        Utility().snackBarForInternetIssue();
      }
    });
  }

  void showWaitForGreen() {
    final random = Random();
    int randomSeconds = 1 + random.nextInt(4);

    randomTime = randomTime + randomSeconds;
    printf('---random--second---->$randomSeconds');
    timerWaitForGreen = Timer(Duration(seconds: randomSeconds), () async {
      showGreen();
    });

    isGreen = false;
    isWaitForGreen = true;
    update([stateId]);
  }

  void showGreen() {
    var now = DateTime.now().millisecondsSinceEpoch;
    startTimeForGreenCard = now.toString();
    update([stateId]);

    timerGreen = Timer(const Duration(milliseconds: 10000), () async {
      printf('<------attempt-fail----->');
      reactionTestList.add(ReactionTest(
          startTestTime: startTestTime,
          startTimeForGreenCard: '0',
          tapTimeForGreenCard: '0',
          isTap: 'false'));
      showWaitForGreen();
    });

    isWaitForGreen = false;
    isGreen = true;
    update([stateId]);
  }

  void clickOnRedTap() {
    printf('<--clicked-on-red-tap----->');
    int count = 1;
    listForFalseStarts.add(count);
  }

  void clickOnGreen() {
    printf('<------save-time-and-show-wait-for-green----->');
    var now = DateTime.now().millisecondsSinceEpoch;
    tapTimeForGreenCard = now.toString();
    update([stateId]);

    reactionTestList.add(ReactionTest(
        startTestTime: startTestTime,
        startTimeForGreenCard: startTimeForGreenCard,
        tapTimeForGreenCard: tapTimeForGreenCard,
        randomTime: randomTime,
        isTap: 'true'));

    timerGreen?.cancel();
    showWaitForGreen();
  }

  void stopAllTimer() {
    timerFor3Minutes?.cancel();
    timerWaitForGreen?.cancel();
    timerGreen?.cancel();
  }

  int findHighest({required List<int> list}) {
    int highest = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] > highest) {
        highest = list[i];
      }
    }
    return highest;
  }

  int findLowest({required List<int> list}) {
    int lowest = list[0];
    for (int i = 1; i < list.length; i++) {
      if (list[i] < lowest) {
        lowest = list[i];
      }
    }
    return lowest;
  }
}

class GraphModel {
  GraphModel(this.title, this.value);

  final String title;
  int value;
}
