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

class ReactionTimeTestController extends BaseController
    with GetSingleTickerProviderStateMixin {
  static String stateId = 'reaction_test_ui';

  Timer? timerFor3Minutes, timerWaitForGreen, timerGreen;

  bool isWaitForGreen = false;
  bool isGreen = false;
  bool isResult = false;

  List<ReactionTest> reactionTestList = [];

  List<ReactionTest> reactionTestListForIso = [];

  List<ReactionTest> reactionTestListFilter = [];

  List<ReactionTest> listForAscending = [];

  List<int> listOfDifference = [];
  List<int> listOfAscFirst = [];
  List<int> listOfAscSecond = [];

  List<int> listForFalseStartCount = [];
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
  int totalPositiveDiff = 0;
  double avg = 0;

  int totalSqrt = 0;
  List<int> listForSqrt = [];

  List<GraphModel> listForGraph = [];

  var speed = '0';
  var falseStart = '0';
  var accuracy = '0';
  var variation = '0';
  var plusLapses = '0';
  var avgForIsi0to2 = '0';
  var avgForIsi2to4 = '0';

  var delta = '0';

  var slowingRate = '0';
  var performanceDecline = '0';
  var LPM = '0';
  var FPM = '0';
  var IQR = '0';
  var PSR = '0';
  var RTRT = '0';

  var vigilanceIndex = '0',
      alertness = '',
      resilience = '0',
      fatigue = '0',
      attention = '0';

  var cognitiveFlexibility = '', responseControl = '', cognitiveLoad = '0';

  late ReactionTestModel reactionTestModel;

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.reactionTestTable);

  int randomTime = 0;

  double maximumValue = 0;

  int startTime = 180000;

  List<RandomTime> valueForIsi = [];

  //isi 0 to 2 2 to 4

  List<int> listForIsi0to2 = [];
  int countForIsi0to2 = 0;
  int totalIsi0to2 = 0;

  List<int> listForIsi2to4 = [];
  int countForIsi2to4 = 0;
  int totalIsi2to4 = 0;

  int randomTimeForIso = 0;

  int startTestTimeInMs = 0;

  double firstQuestion = 0;
  var isSelected = '';
  var textNotes = '';
  var arguments = Get.arguments;

  double opacity = 1.0;

//  late Timer timerForAnimation;

  var animationText = '';

  List<int> listOfDifferenceBetween100To350 = [];
  double meanRTTAvg = 0;

  List<int> listForPlusLapses355 = [];
  List<int> listForPlusLapses500 = [];
  List<int> listForPlusLapses700 = [];

  List<int> listForOneMinuteDiff = [];
  List<int> listForSecondMinuteDiff = [];
  List<int> listForThirdMinuteDiff = [];

  int totalForOneMinDiff = 0;
  int totalForSecondMinDiff = 0;
  int totalForThirdMinDiff = 0;

  var avgForFirstMin = '0';
  var avgForSecondMin = '0';
  var avgForThirdMin = '0';

  List<int> listForFalseStart = [];

  List<int> listForFalseStartIsi0to2 = [];

  //int countForFalseStart = 0;
  int countForFalseStartIsi0to2 = 0;
  int totalFalseIsi0to2 = 0;

  List<int> listForFalseStartIsi2to4 = [];
  int countForFalseStartIsi2to4 = 0;
  int totalFalseStartIsi2to4 = 0;

  int countForPlusLapsesIsi2to4 = 0;
  int countForPlusLapsesIsi0to2 = 0;

  var performanceScore = '0';
  var successRate = '0';

  var lapseProbability = '0';
  var deltaIsi = '0';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----ReactionTimeTestController---->');
      reactionTestModel = ReactionTestModel();
      getUserId();

      if (arguments != null) {
        try {
          firstQuestion = arguments[0];

          isSelected = arguments[1];

          textNotes = arguments[2];

          printf(
              '<--arguments---->$firstQuestion---->$isSelected--->$textNotes');
        } catch (e) {
          printf('<----exe-arguments-->$e');
        }
      } else {
        printf('<----null-arguments------>');
      }
      //startFadeAnimation();
    });
  }

  void startTest() {
    var now = DateTime.now();
    startTestTime = now.toString();
    startTestTimeInMs = now.millisecondsSinceEpoch;
    //printf('---start-test-time---->$startTestTime');
    update([stateId]); // 180000
    timerFor3Minutes = Timer(Duration(milliseconds: startTime), () async {
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

      int mrtLast = 0;
      int countForMrtLast = 0;

      int mrtFirst = 0;
      int countForMrtFirst = 0;

      printf(
          '------------total-reactionTestListFilter--->${reactionTestListFilter.length}');
      listOfDifference.clear();
      for (int i = 0; i < reactionTestListFilter.length; i++) {
        int diff = int.parse(
                reactionTestListFilter[i].tapTimeForGreenCard.toString()) -
            int.parse(
                reactionTestListFilter[i].startTimeForGreenCard.toString());

        total = total + diff;
        listOfDifference.add(diff);

        int? randomTime = reactionTestListFilter[i].randomTime;

        if (randomTime! >= 120 && randomTime <= 180) {
          mrtLast = mrtLast + diff;
          countForMrtLast = countForMrtLast + 1;
        } else if (randomTime >= 0 && randomTime <= 60) {
          mrtFirst = mrtFirst + diff;
          countForMrtFirst = countForMrtFirst + 1;
        }

        listForGraph.add(GraphModel(randomTime.toString(), diff));

        if (diff >= 355) {
          listForPlusLapsesCount.add(1);
        } else if (diff < 100) {
          listForFalseStartCount.add(1);
          listForFalseStart.add(diff);
        } else if (diff >= 100 && diff < 355) {
          listForValidStimuli.add(1);
        }

        if (diff >= 100 && diff < 355) {
          totalPositiveDiff = totalPositiveDiff + diff;
          listOfDifferenceBetween100To350.add(diff);
        } else if (diff >= 355 && diff < 500) {
          listForPlusLapses355.add(diff);
        } else if (diff >= 500 && diff < 700) {
          listForPlusLapses500.add(diff);
        } else if (diff >= 700) {
          listForPlusLapses700.add(diff);
        }

        printf(
            '----difference-for-time-test---->$diff---random-time-->${reactionTestListFilter[i].randomTime}');
      }

      listOfDifference.sort();

      //---------------------------------------------------------------

      printf(
          '<---total-for-one-min--->$totalForOneMinDiff----second--->$totalForSecondMinDiff---third--->$totalForThirdMinDiff');

      if (listForOneMinuteDiff.isNotEmpty) {
        double oneMinAvg = totalForOneMinDiff / listForOneMinuteDiff.length;
        avgForFirstMin = oneMinAvg.toInt().toString();
      }

      if (listForSecondMinuteDiff.isNotEmpty) {
        double secondMinAvg =
            totalForSecondMinDiff / listForSecondMinuteDiff.length;
        avgForSecondMin = secondMinAvg.toInt().toString();
      }

      if (listForThirdMinuteDiff.isNotEmpty) {
        double thirdMinAvg =
            totalForThirdMinDiff / listForThirdMinuteDiff.length;
        avgForThirdMin = thirdMinAvg.toInt().toString();
      }

      printf(
          '<--total-one-minute->${listForOneMinuteDiff.length}--second--->${listForSecondMinuteDiff.length}--third-->${listForThirdMinuteDiff.length}');

      printf(
          '<------avg-for-one-min--->$avgForFirstMin---second-->$avgForSecondMin---third--->$avgForThirdMin');

      if (listOfDifferenceBetween100To350.isNotEmpty) {
        printf(
            '<----------------------------------------------------------------------------->');

        printf(
            '<-----total-plus-lapses-355-to-500--->${listForPlusLapses355.length}--plus-lapses-500-to-700-->${listForPlusLapses500.length}----plus-lapses-greater-700-->${listForPlusLapses700.length}');
        printf('<-----total-false-start--->${listForFalseStart.length}');
        printf(
            '<---total-diff--->${listOfDifference.length}-----total-valid-100-to-350-->${listOfDifferenceBetween100To350.length}');
        printf('<---total-positive-diff----->$totalPositiveDiff');

        double meanRTT =
            totalPositiveDiff / listOfDifferenceBetween100To350.length;

        meanRTTAvg = meanRTT.toDouble().toPrecision(2);
        printf('<----mean-rtt------->$meanRTT---->$meanRTTAvg');

        double meanNewSpeed = (meanRTT / 1000) * 18;

        printf('<---------mean-new-speed--->$meanNewSpeed--------->');

        double fastest10Per =
            calculateAverageFastest10Percent(listOfDifferenceBetween100To350);

        average = meanRTTAvg.toInt().toString();

        printf('<---------fastest--->$fastest10Per--------->');

        double slowest10per =
            calculateAverageSlowest10Percent(listOfDifferenceBetween100To350);

        printf('<---------slowest--->$slowest10per--------->');

        double dlt = slowest10per - fastest10Per;

        slowest = slowest10per.toInt().toString();

        fastest = fastest10Per.toInt().toString();

        delta = dlt.toInt().toString();

        double sp = 1000 / meanRTT;

        speed = sp.toDouble().toStringAsFixed(4).toString();

        printf('<---------delta--->$delta-----speed---->$speed');
        printf(
            '<----------------------------------------------------------------------------->');
      }

      //---------------------------------------------------------------

      if (listOfDifference.isNotEmpty) {
        double rtsr = (mrtLast - mrtFirst) / mrtFirst;

        double cpd = (mrtLast - mrtFirst) / 3;

        double lpm = listForPlusLapsesCount.length / 3;

        double fpm = listForFalseStartCount.length / 3;

        double iqr = calculateIQR(listOfDifference);

        double psr = calculatePSR(listOfDifference);

        int baseline = listOfDifference.reduce((a, b) => a + b) ~/
            listOfDifference.length; // Calculate baseline

        printf('-----baseline--->$baseline');

        double rtrt = calculateRTRT(listOfDifference, baseline);

        slowingRate = rtsr.toDouble().toStringAsFixed(2);

        performanceDecline = cpd.toDouble().toStringAsFixed(2);

        LPM = lpm.toDouble().toStringAsFixed(2);

        FPM = fpm.toDouble().toStringAsFixed(2);

        IQR = iqr.toDouble().toStringAsFixed(2);

        PSR = psr.toDouble().toStringAsFixed(2);

        RTRT = rtrt.toDouble().toStringAsFixed(2);

        printf('-----RTSR----slowing rate-->$rtsr');
        printf('-----CPD---performance-decline--->$cpd');
        printf('-----LPM---lapses/M--->$lpm');
        printf('-----FPM----False starts/M-->$fpm');
        printf('-----calculate-iqr---->$iqr');
        printf('-----calculate-psr---PSR-->$psr');
        printf('-----calculate-rtrt---recovery-time->$rtrt');

        double cvi = calculateCVI(listOfDifference, 300);
        vigilanceIndex = cvi.toDouble().toStringAsFixed(2);
        printf("Cognitive -> Vigilance Index (CVI): $vigilanceIndex");

        double alScore = calculateAlertnessScore(listOfDifference, 250);

        alertness = alScore.toDouble().toStringAsFixed(2);

        printf("Alertness Score > Alertness : $alertness");

        double resilienceScore = calculateResilienceScore(listOfDifference);
        resilience = resilienceScore.toDouble().toStringAsFixed(2);
        printf("Resilience to Distraction Score -> Resilience: $resilience");

        double fatigueRisk = calculateFatigueRisk(listOfDifference);
        fatigue = fatigueRisk.toDouble().toStringAsFixed(2);
        printf("fatigueRisk ->fatigue : $fatigue");

        double vigilanceAndAttentionScore =
            calculateVigilanceAndAttention(listOfDifference);

        attention = vigilanceAndAttentionScore.toDouble().toStringAsFixed(2);
        printf("Vigilance and Attention Score -> Attention: $attention");

        printf(
            '<-------------------------------------------------------------------->');
        //printf('----total-graph-list--->${listForGraph.length}');
        printf(
            '----total--for-lapses-count----->${listForPlusLapsesCount.length}');
        printf(
            '----total--for-false-count----->${listForFalseStartCount.length}');
        printf(
            '----total-for-valid-stimuli-count----->${listForValidStimuli.length}');
        printf(
            '<-------------------------------------------------------------------->');
      }

      for (int i = 0; i < reactionTestListForIso.length; i++) {
        int diff = int.parse(
                reactionTestListForIso[i].tapTimeForGreenCard.toString()) -
            int.parse(
                reactionTestListForIso[i].startTimeForGreenCard.toString());

        int randomTime = reactionTestListForIso[i].randomTime!;

        if (diff > 100 && diff < 355) {
          if (randomTime <= 2) {
            listForIsi0to2.add(diff);
            totalIsi0to2 = totalIsi0to2 + diff;
            countForIsi0to2 = countForIsi0to2 + 1;
          } else if (randomTime > 2) {
            listForIsi2to4.add(diff);
            totalIsi2to4 = totalIsi2to4 + diff;
            countForIsi2to4 = countForIsi2to4 + 1;
          }
        } else if (diff < 100 && randomTime > 2) {
          countForFalseStartIsi2to4 = countForFalseStartIsi2to4 + 1;
        } else if (diff < 100 && randomTime <= 2) {
          countForFalseStartIsi0to2 = countForFalseStartIsi0to2 + 1;
        } else if (diff >= 355 && randomTime > 2) {
          countForPlusLapsesIsi2to4 = countForPlusLapsesIsi2to4 + 1;
        } else if (diff >= 355 && randomTime <= 2) {
          countForPlusLapsesIsi0to2 = countForPlusLapsesIsi0to2 + 1;
        }

        // printf('----difference-for-time-iso-test---->$diff---random-time-->$randomTime');
      }

      printf(
          '<------plus-lapses-0-to-2->$countForPlusLapsesIsi0to2---2-to-4-->$countForPlusLapsesIsi2to4');

      double cognitiveFlexibilityScore =
          calculateCognitiveFlexibility(listForIsi0to2, listForIsi2to4);

      cognitiveFlexibility =
          cognitiveFlexibilityScore.toDouble().toStringAsFixed(2);

      printf(
          "Cognitive Flexibility Score -> Cognitive Flexibility: $cognitiveFlexibility");

      double responseControlScore = calculateResponseControl(listOfDifference);
      responseControl = responseControlScore.toDouble().toStringAsFixed(2);

      printf("Response Control Score -> Response Control: $responseControl");

      double cognitiveLoadScore =
          calculateCognitiveLoad(listForIsi0to2, listForIsi2to4);
      cognitiveLoad = cognitiveLoadScore.toDouble().toStringAsFixed(2);
      printf("Cognitive Load Score -> Cognitive Load: $cognitiveLoad");

      //double sleepQualityScore = calculateSleepQualityIndicator(listOfDifference, 1);
      //printf("Sleep Quality Indicator Score: $sleepQualityScore");

      //printf('----total--iso--value--->$totalIsoValue----count-->$countForIso');
      //printf('----total--iso--value--greater->$totalIsoValueGreater----count-->$countForIsoGreater');

      if (listOfDifference.isNotEmpty) {
        //int l = findHighest(list: listOfDifference);
        //slowest = l.toString();

        //int f = findLowest(list: listOfDifference);
        //fastest = f.toString();

        avg = total / listOfDifference.length;

        //average = avg.toInt().toString();

        //double sp = 1000 / avg;

        //speed = sp.toDouble().toStringAsFixed(4).toString();

        falseStart = listForFalseStartCount.length.toString();

        if (totalIsi0to2 > 0 || countForIsi0to2 > 0) {
          double avgIsi = (totalIsi0to2 / countForIsi0to2);

          avgForIsi0to2 = avgIsi.toDouble().toStringAsFixed(2);
        }

        // printf('<-------totalIsi2to4->$totalIsi2to4---countForIsi2to4--->$countForIsi2to4');

        if (totalIsi2to4 > 0 || countForIsi2to4 > 0) {
          double avgIsi2to4 = (totalIsi2to4 / countForIsi2to4);

          avgForIsi2to4 = avgIsi2to4.toDouble().toStringAsFixed(2);
        }

        // printf('<---------avg-for-delta-isi---->$avgForIsi2to4---to----->$avgForIsi0to2');

        double dIsi = double.parse(avgForIsi2to4) - double.parse(avgForIsi0to2);

        deltaIsi = dIsi.toInt().toString();
        printf(
            '<--------delta-isi---->$deltaIsi----avg-start-0-to2->$avgForIsi0to2---2-to-4-->$avgForIsi2to4');

        // double fastest10Per = calculateAverageFastest10Percent(listOfDifference);

        double slowest10per =
            calculateAverageSlowest10Percent(listOfDifference);

        //slowest = slowest10per.toInt().toString();

        maximumValue = slowest10per.toInt() + 100;

        //fastest = fastest10Per.toInt().toString();

        printf('-------fastest---->$fastest------slowest-->$slowest');
        //printf('----new---fastest---->$fastest10Per------slowest-->$slowest10per');

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

        //listOfDifference.add(diff);
      }
      printf(
          '<-------------------------------------------------------------------->');

      printf(
          '----------total-listOfDifference------->${listOfDifference.length}------between-100-to-35--->${listOfDifferenceBetween100To350.length}');

      // int variance = totalSqrt ~/ reactionTestListFilter.length;
      //
      // double stdDeviation = sqrt(variance);
      //
      // double finalVariation = (stdDeviation / avg) * 100;

      int variance = totalSqrt ~/ listOfDifferenceBetween100To350.length;

      double stdDeviation = sqrt(variance);

      double finalVariation = (stdDeviation / meanRTTAvg) * 100;

      final ps =
          (listForValidStimuli.length / reactionTestListFilter.length) * 100;

      plusLapses = listForPlusLapsesCount.length.toString();
      accuracy = ps.roundToDouble().toString();

      variation = finalVariation.toDouble().toStringAsFixed(2);
      printf('----accuracy---->$ps');

      printf('-listForPlusLapsesCount-->${listForPlusLapsesCount.length}');
      printf('-listForFalseStartCount-->${listForFalseStartCount.length}');
      printf(
          '-listOfDifferenceBetween100To350-->${listOfDifferenceBetween100To350.length}');

      double sr = listOfDifferenceBetween100To350.length /
          (listOfDifferenceBetween100To350.length +
              listForPlusLapsesCount.length +
              listForFalseStartCount.length) *
          100;

      double lp = listForPlusLapsesCount.length /
          listOfDifferenceBetween100To350.length;

      lapseProbability = lp.toInt().toString();
      printf('---lapseProbability--->$lapseProbability');

      final pfs = 100 %
          -(((listForPlusLapsesCount.length + listForFalseStartCount.length) /
                  (listOfDifferenceBetween100To350.length +
                      listForFalseStartCount.length)) *
              100);

      performanceScore = pfs.toInt().toString();

      successRate = sr.toInt().toString();

      printf('---success-rate--->$successRate');
      printf('----performanceScore---->$performanceScore');

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
    reactionTestModel.reactionTestTime =
        '${now.hour}:${now.minute}:${now.second}';
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
    reactionTestModel.isi0to2 = avgForIsi0to2;
    reactionTestModel.isi2to4 = avgForIsi2to4;
    reactionTestModel.slowingRate = slowingRate;
    reactionTestModel.performanceDecline = performanceDecline;
    reactionTestModel.lpm = LPM;
    reactionTestModel.fpm = FPM;
    reactionTestModel.iqr = IQR;
    reactionTestModel.psr = PSR;
    reactionTestModel.rtrt = RTRT;
    reactionTestModel.vigilanceIndex = vigilanceIndex;
    reactionTestModel.alertness = alertness;
    reactionTestModel.resilience = resilience;
    reactionTestModel.fatigue = fatigue;
    reactionTestModel.attention = attention;
    reactionTestModel.cognitiveFlexibility = cognitiveFlexibility;
    reactionTestModel.responseControl = responseControl;
    reactionTestModel.cognitiveLoad = cognitiveLoad;
    reactionTestModel.alertnessRating = firstQuestion.toString();
    reactionTestModel.supplementsTaken = isSelected.toString();
    //
    reactionTestModel.deltaSF = delta;
    reactionTestModel.lapseProbability = lapseProbability;
    reactionTestModel.miniLapse = listForPlusLapses355.length.toString();
    reactionTestModel.plusLapse = listForPlusLapses500.length.toString();
    reactionTestModel.sLapse = listForPlusLapses700.length.toString();
    reactionTestModel.deltaIsi = deltaIsi;
    reactionTestModel.falseStartIsi0to2 = countForFalseStartIsi0to2.toString();
    reactionTestModel.falseStartIsi2to4 = countForFalseStartIsi2to4.toString();
    reactionTestModel.plusLapseIsi0to2 = countForPlusLapsesIsi0to2.toString();
    reactionTestModel.plusLapseIsi2to4 = countForPlusLapsesIsi2to4.toString();
    reactionTestModel.averageFirstMin = avgForFirstMin;
    reactionTestModel.averageSecondMin = avgForSecondMin;
    reactionTestModel.averageThirdMin = avgForThirdMin;
    reactionTestModel.notes = textNotes;
    //
    reactionTestModel.reactionTest = reactionTestListFilter;

    //Alertness rating : 5
    //Supplements taken : No

    printf(
        'reactionTimeTest-Json--->${jsonEncode(reactionTestModel.toJson())}');

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
            Get.back(result: true);
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
    int randomSeconds = 1 + random.nextInt(3);

    randomTimeForIso = randomSeconds;
    randomTime = randomTime + randomSeconds;
    printf('---random--second---->$randomSeconds');
    timerWaitForGreen = Timer(Duration(seconds: randomSeconds), () async {
      showGreen();
    });

    //animationText = randomTime.toString();
    //startFadeAnimation();

    isGreen = false;
    isWaitForGreen = true;
    update([stateId]);
  }

  void showGreen() {
    timerGreen = Timer(const Duration(milliseconds: 1000), () async {
      printf('<------attempt-fail----->');
      reactionTestList.add(ReactionTest(
          startTestTime: startTestTime,
          startTimeForGreenCard: '0',
          tapTimeForGreenCard: '0',
          randomTime: randomTime,
          isTap: 'false'));

      reactionTestListForIso.add(ReactionTest(
          startTestTime: startTestTime,
          startTimeForGreenCard: '0',
          tapTimeForGreenCard: '0',
          randomTime: randomTimeForIso,
          isTap: 'false'));

      showWaitForGreen();
    });

    var now = DateTime.now().millisecondsSinceEpoch;
    startTimeForGreenCard = now.toString();
    //update([stateId]);

    opacity = 1.0;
    isWaitForGreen = false;
    isGreen = true;
    update([stateId]);
  }

  void clickOnRedTap() {
    printf('<--clicked-on-red-tap----->');
    int count = 1;
    listForFalseStartCount.add(count);
  }

  void clickOnGreen() {
    printf('<------save-time-and-show-wait-for-green----->');
    var now = DateTime.now().millisecondsSinceEpoch;
    tapTimeForGreenCard = now.toString();
    showWaitForGreen();
    update([stateId]);

    double rt =
        (int.parse(tapTimeForGreenCard.toString()) - startTestTimeInMs) / 1000;

    int diff = int.parse(tapTimeForGreenCard.toString()) -
        int.parse(startTimeForGreenCard.toString());

    animationText = diff.toString();

    printf('----rt-time---->$rt---->$diff');
    if (diff > 100 && diff <= 355) {
      if (rt < 60) {
        listForOneMinuteDiff.add(diff);
        totalForOneMinDiff = totalForOneMinDiff + diff;
      } else if (rt >= 60 && rt < 120) {
        listForSecondMinuteDiff.add(diff);
        totalForSecondMinDiff = totalForSecondMinDiff + diff;
      } else if (rt >= 120 && rt < 180) {
        listForThirdMinuteDiff.add(diff);
        totalForThirdMinDiff = totalForThirdMinDiff + diff;
      }
    }

    reactionTestList.add(ReactionTest(
        startTestTime: startTestTime,
        startTimeForGreenCard: startTimeForGreenCard,
        tapTimeForGreenCard: tapTimeForGreenCard,
        randomTime: rt.toInt(),
        isTap: 'true'));

    reactionTestListForIso.add(ReactionTest(
        startTestTime: startTestTime,
        startTimeForGreenCard: startTimeForGreenCard,
        tapTimeForGreenCard: tapTimeForGreenCard,
        randomTime: randomTimeForIso,
        isTap: 'true'));

    timerGreen?.cancel();
    //showWaitForGreen();
  }

  @override
  void onClose() {
    printf('<---onClose---and--stop--all-timers----->');
    //timerForAnimation.cancel();
    stopAllTimer();
    super.onClose();
  }

  @override
  void dispose() {
    printf('<---dispose---and--stop--all-timers----->');
    //timerForAnimation.cancel();
    stopAllTimer();
    super.dispose();
  }

  void startFadeAnimation() {
    // timerForAnimation = Timer(const Duration(milliseconds: 200), () async {
    //   //opacity = opacity == 1.0 ? 0.0 : 1.0;
    //   opacity = 0.0;
    //   update([stateId]);
    // });
    showReactionTime();
  }

  void showReactionTime() async {
    // Start the fade-in animation
    opacity = 1.0;
    update([stateId]);
    await Future.delayed(const Duration(milliseconds: 200));

    // Stay visible for 400 ms
    await Future.delayed(const Duration(milliseconds: 400));

    // Start the fade-out animation
    opacity = 0.0;
    update([stateId]);
    await Future.delayed(const Duration(milliseconds: 200));
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

  double calculateAverageFastest10Percent(List<int> reactionTimes) {
    // Sort the list in ascending order
    List<int> sortedTimes = List.from(reactionTimes)..sort();
    // Calculate the number of elements that make up 10%
    int count = (sortedTimes.length * 0.1).ceil();
    // Get the fastest 10% from the start of the sorted list
    List<int> fastest10Percent = sortedTimes.take(count).toList();
    // Calculate and return the average of the fastest 10%
    return fastest10Percent.reduce((a, b) => a + b) / fastest10Percent.length;
  }

  double calculateAverageSlowest10Percent(List<int> reactionTimes) {
    // Sort the list in ascending order
    List<int> sortedTimes = List.from(reactionTimes)..sort();
    // Calculate the number of elements that make up 10%
    int count = (sortedTimes.length * 0.1).ceil();
    // Get the slowest 10% from the end of the sorted list
    List<int> slowest10Percent = sortedTimes.reversed.take(count).toList();
    // Calculate and return the average of the slowest 10%
    return slowest10Percent.reduce((a, b) => a + b) / slowest10Percent.length;
  }

  double calculateIQR(List<int> data) {
    if (data.isNotEmpty) {
      // Step 1: Sort the data
      data.sort();

      // Step 2: Calculate Q1
      List<int> lowerHalf = data.sublist(0, data.length ~/ 2);
      double q1 = findMedian(lowerHalf);

      // Step 3: Calculate Q3
      List<int> upperHalf = data.sublist((data.length + 1) ~/ 2);
      double q3 = findMedian(upperHalf);

      // Step 4: Calculate IQR
      double iqr = q3 - q1;
      return iqr;
    } else {
      return 0;
    }
  }

  double calculatePSR(List<int> data) {
    if (data.isNotEmpty) {
      // Count reactions above 300 ms
      int slowReactions = data.where((time) => time > 300).length;
      int totalReactions = data.length;

      // Calculate PSR
      double psr = (slowReactions / totalReactions) * 100;
      return psr;
    } else {
      return 0;
    }
  }

  double calculateRTRT(List<int> data, int baseline) {
    if (data.isNotEmpty) {
      List<int> recoveryTimes = [];

      for (int i = 0; i < data.length; i++) {
        if (data[i] > 355) {
          // Identify a lapse
          int j = i + 1;
          int recoveryTime = 0;

          // Calculate time to recover back to baseline
          while (j < data.length && data[j] > baseline) {
            recoveryTime += (data[j] - baseline).abs();
            j++;
          }

          // Only add to recovery times if we successfully returned to baseline

          if (j <= data.length) {
            recoveryTimes.add(recoveryTime ~/ (j - i));
          }
        }
      }

      // Calculate average RTRT across all lapses
      double averageRTRT = recoveryTimes.isNotEmpty
          ? recoveryTimes.reduce((a, b) => a + b) / recoveryTimes.length
          : 0.0;

      double rtrtScore = 100 - ((averageRTRT / baseline) * 100);

      return rtrtScore.clamp(0, 100); // Ensure the score is within 0-100 range
    } else {
      return 0;
    }

    //return averageRTRT;
  }

  double calculateCVI(List<int> data, int baseline) {
    if (data.isNotEmpty) {
      // Calculate Mean Reaction Time (MRT Score)
      double mrt = data.reduce((a, b) => a + b) / data.length;
      double mrtScore = 100 - ((mrt / baseline) * 100).clamp(0, 100);

      // Calculate Reaction Time Consistency (CV Score)
      double mean = mrt;
      double variance = data
              .map((time) => (time - mean) * (time - mean))
              .reduce((a, b) => a + b) /
          data.length;
      double standardDeviation = sqrt(variance); //variance.sqrt();
      double cvScore = 100 - ((standardDeviation / mean) * 100).clamp(0, 100);

      // Calculate Lapse Rate Score
      int lapseCount = data.where((time) => time > 355).length;
      double lapseScore =
          100 - ((lapseCount / data.length) * 100).clamp(0, 100);

      // Calculate Reaction Time Recovery Time (RTRT) Score
      double rtrtScore = calculateRTRT(data, baseline);

      // Calculate CVI as a weighted sum of all components
      double cvi = (0.4 * mrtScore) +
          (0.2 * cvScore) +
          (0.2 * lapseScore) +
          (0.2 * rtrtScore);
      return cvi.clamp(0, 100);
    } else {
      return 0;
    }
  }

  double calculateAlertnessScore(List<int> data, int idealFastestRT) {
    if (data.isNotEmpty) {
      // Step 1: Calculate False Starts (reaction times < 150 ms)
      int falseStarts = data.where((time) => time < 150).length;
      int totalReactions = data.length;

      // Step 2: Calculate Fastest 10% Reaction Time (average of fastest 10% reactions)
      data.sort();
      int fastest10PercentCount = (data.length * 0.1).round();
      List<int> fastest10Percent = data.take(fastest10PercentCount).toList();
      double averageFastest10PercentRT =
          fastest10Percent.reduce((a, b) => a + b) / fastest10Percent.length;

      // Step 3: Calculate Alertness Score
      double alertnessScore = 100 -
          ((falseStarts / totalReactions) * 50) -
          ((averageFastest10PercentRT / idealFastestRT) * 50);

      return alertnessScore.clamp(0, 100);
    } else {
      return 0;
    } // Ensure the score is between 0 and 100
  }

  double calculateResilienceScore(List<int> data) {
    if (data.isNotEmpty) {
      // Step 1: Calculate Average Reaction Time
      double avgReactionTime = data.reduce((a, b) => a + b) / data.length;

      // Step 2: Calculate Average Recovery Time
      List<int> recoveryTimes = [];

      for (int i = 0; i < data.length; i++) {
        if (data[i] > 355) {
          // Identify a lapse (reaction time > 355 ms)
          int j = i + 1;
          int recoveryTime = 0;

          // Calculate time to recover back to baseline
          while (j < data.length && data[j] > avgReactionTime) {
            recoveryTime += (data[j] - avgReactionTime).abs().toInt();
            j++;
          }

          if (j <= data.length) {
            recoveryTimes.add(recoveryTime);
          }
        }
      }

      // Step 3: Calculate Average Recovery Time
      double avgRecoveryTime = recoveryTimes.isNotEmpty
          ? recoveryTimes.reduce((a, b) => a + b) / recoveryTimes.length
          : 0.0;

      // Step 4: Calculate Resilience to Distraction Score
      //double resilienceScore = 100 - ((avgRecoveryTime / avgReactionTime) * 100);

      printf(
          '---resilienceScore-value---->avgRtime-->$avgRecoveryTime---avgRecTime-->$avgReactionTime');

      double resilienceScore = 100 - (avgRecoveryTime * 100 / avgReactionTime);

      return resilienceScore;
    } else {
      return 0;
    } // Ensure the score is between 0 and 100
  }

  double calculateFatigueRisk(List<int> data) {
    if (data.isNotEmpty) {
      // Step 1: Calculate Baseline Reaction Time
      double baselineRT = data.reduce((a, b) => a + b) / data.length;

      // Step 2: Calculate CPD (Cumulative Performance Decline)
      int segments = 3; // Dividing the test into 3 segments
      int segmentSize = (data.length / segments).floor();
      List<double> segmentAverages = [];

      for (int i = 0; i < segments; i++) {
        List<int> segment =
            data.sublist(i * segmentSize, (i + 1) * segmentSize);
        double segmentAvg = segment.reduce((a, b) => a + b) / segment.length;
        segmentAverages.add(segmentAvg);
      }

      double cpd = (segmentAverages.last - segmentAverages.first) / segments;

      // Step 3: Calculate RTSR (Reaction Time Slowing Rate)
      double rtsr = (segmentAverages.last - segmentAverages.first) /
          segmentAverages.first;

      // Step 4: Calculate Fatigue Risk
      double fatigueRisk = 100 - ((cpd / baselineRT) * 50) - (rtsr * 50);

      return fatigueRisk.clamp(0, 100); // Ensure the score is between 0 and 100
    } else {
      return 0;
    }
  }

  double calculateVigilanceAndAttention(List<int> data) {
    if (data.isNotEmpty) {
      // Step 1: Calculate Total Reactions
      int totalReactions = data.length;

      // Step 2: Calculate Number of Lapses (reaction times > 355 ms)
      int lapses = data.where((time) => time > 355).length;

      // Step 3: Calculate RTSR (Reaction Time Slowing Rate)
      int segments = 3; // Dividing the test into 3 segments
      int segmentSize = (data.length / segments).floor();
      List<double> segmentAverages = [];

      for (int i = 0; i < segments; i++) {
        List<int> segment =
            data.sublist(i * segmentSize, (i + 1) * segmentSize);
        double segmentAvg = segment.reduce((a, b) => a + b) / segment.length;
        segmentAverages.add(segmentAvg);
      }

      double rtsr = (segmentAverages.last - segmentAverages.first) /
          segmentAverages.first;

      // Step 4: Calculate Vigilance and Attention Score
      double vigilanceAndAttention =
          100 - ((lapses / totalReactions) * 50) - (rtsr * 50);

      return vigilanceAndAttention.clamp(0, 100);
    } else {
      return 0;
    }
    // Ensure the score is between 0 and 100
  }

  double calculateCognitiveFlexibility(List<int> data0to2, List<int> data2to4) {
    // Step 1: Calculate SD of ISI 0-2 sec
    if (data0to2.isNotEmpty && data2to4.isNotEmpty) {
      double sd0to2 = calculateStandardDeviation(data0to2);

      // Step 2: Calculate SD of ISI 2-4 sec
      double sd2to4 = calculateStandardDeviation(data2to4);

      // Step 3: Calculate Cognitive Flexibility Score
      double cognitiveFlexibility = 100 - ((sd0to2 / sd2to4) * 50);

      return cognitiveFlexibility.clamp(
          0, 100); // Ensure the score is between 0 and 100
    } else {
      return 0;
    }
  }

  // Helper function to calculate standard deviation
  double calculateStandardDeviation(List<int> data) {
    if (data.isNotEmpty) {
      double mean = data.reduce((a, b) => a + b) / data.length;
      double sumOfSquaredDiffs = data
          .map((time) => pow(time - mean, 2))
          .reduce((a, b) => a + b)
          .toDouble();
      double variance = sumOfSquaredDiffs / data.length;
      return sqrt(variance);
    } else {
      return 0;
    }
  }

  double calculateResponseControl(List<int> data) {
    if (data.isNotEmpty) {
      // Step 1: Calculate Total Reactions
      int totalReactions = data.length;

      // Step 2: Calculate Number of False Starts (reaction times < 150 ms)
      int falseStarts = data.where((time) => time < 150).length;

      // Step 3: Calculate Response Control Score
      double responseControl = 100 - ((falseStarts / totalReactions) * 100);

      return responseControl.clamp(0, 100);
    } else {
      return 0;
    }
    // Ensure the score is between 0 and 100
  }

  double calculateCognitiveLoad(List<int> data0to2, List<int> data2to4) {
    if (data0to2.isNotEmpty && data2to4.isNotEmpty) {
      // Step 1: Calculate Average RT for ISI 0-2 sec
      double avgRT0to2 = data0to2.reduce((a, b) => a + b) / data0to2.length;

      // Step 2: Calculate Average RT for ISI 2-4 sec
      double avgRT2to4 = data2to4.reduce((a, b) => a + b) / data2to4.length;

      // Step 3: Calculate Cognitive Load Score
      double cognitiveLoad = 100 - ((avgRT2to4 / avgRT0to2) * 50);

      return cognitiveLoad.clamp(0, 100);
    } else {
      return 0;
    }
    // Ensure the score is between 0 and 100
  }

  double calculateSleepQualityIndicator(List<int> data, int durationMinutes) {
    if (data.isNotEmpty) {
      // Step 1: Calculate Baseline Reaction Time
      double baselineRT = data.reduce((a, b) => a + b) / data.length;

      // Step 2: Calculate CPD (Cumulative Performance Decline)
      int segments = 3; // Dividing the test into 3 segments
      int segmentSize = (data.length / segments).floor();
      List<double> segmentAverages = [];

      for (int i = 0; i < segments; i++) {
        List<int> segment =
            data.sublist(i * segmentSize, (i + 1) * segmentSize);
        double segmentAvg = segment.reduce((a, b) => a + b) / segment.length;
        segmentAverages.add(segmentAvg);
      }

      double cpd = (segmentAverages.last - segmentAverages.first) / segments;

      // Step 3: Calculate Number of Lapses per Minute
      int lapses = data.where((time) => time > 355).length;
      double lapsesPerMinute = lapses / durationMinutes;

      // Step 4: Calculate Sleep Quality Indicator
      double sleepQualityIndicator =
          100 - ((cpd / baselineRT) * 50) - (lapsesPerMinute * 50);

      return sleepQualityIndicator; // Ensure the score is between 0 and 100
    } else {
      return 0;
    }
  }

  double findMedian(List<int> list) {
    int n = list.length;
    if (n % 2 == 1) {
      return list[n ~/ 2].toDouble();
    } else {
      return (list[n ~/ 2 - 1] + list[n ~/ 2]) / 2;
    }
  }

  void stopAllTimer() {
    timerFor3Minutes?.cancel();
    timerWaitForGreen?.cancel();
    timerGreen?.cancel();
    printf('<-----stopAllTimer----->');
    //update([stateId]);
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

class RandomTime {
  int? value;
  int? randomTime;

  RandomTime(this.value, this.randomTime);
}
