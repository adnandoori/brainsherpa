import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/fcm/authentication_helper.dart';
import 'package:brainsherpa/models/authentication_model/user_model.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:brainsherpa/widgets/alert_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DashboardController extends BaseController {
  static String stateId = 'dashboard_ui';

  var userId = '';
  var username = '';
  late UserModel userModel;

  var takenAt = '';
  var fastest = '0';
  var slowest = '0';

  var average = '0';
  var accuracy = '0';
  var cognitiveFlexibility = '0';
  var vigilanceIndex = '0';
  var falseStart = '0';
  var lapses = '0';
  var resilience = '0';
  var performanceScore = '0';
  var pfs = '0';
  var trendInsight = '';
  var cognitiveSpeed = '0';
  var resilienceScore = '0';
  var flexibilityScore = '0';
  var focusScore = '0';

  // var displayMonthText = '';
  // var displayWeekText = '';
  // var displayDateText = '';
  // var todayDate = DateTime.now();
  // var formatter = DateFormat('dd-MMM-yyyy');
  // var currentWeek = DateTime.now();
  // var formatterWeek = DateFormat('dd-MMM-yyyy');
  // var currentMonth = DateTime.now();
  // var formatterMonth = DateFormat(' MMM, yyyy');

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.userTable);

  DatabaseReference dbReactionTest =
      FirebaseDatabase.instance.ref().child(AppConstants.reactionTestTable);

  List<ReactionTestModel> reactionTestList = [];

  DateFormat inputFormat = DateFormat("HH:mm dd-MM-yyyy");

  var arguments = Get.arguments;
  var from = '';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----DashboardController---->');

      getUserDetails();
      // displayDateText = formatter.format(todayDate);
      // displayWeekText = formatterWeek.format(currentWeek);
      // displayMonthText = formatterMonth.format(currentMonth);
      if (arguments != null) {
        from = arguments[0];

        printf('<----from----->$from');
        if (from == 'login') {
          getUserId().whenComplete(() {
            getReactionTestList();
          });
        } else {
          navigateToStartTest();
        }
      } else {
        printf('<---exe--arguments---->');
      }
    });
  }

  Future<void> getReactionTestList() async {
    loaderShow();
    reactionTestList.clear();
    update([stateId]);
    printf('---last-user---->$userId');
    DataSnapshot snapshot = await dbReactionTest.child(userId).get();
    if (snapshot.children.isNotEmpty) {
      for (var element in snapshot.children) {
        final data =
            Map<String, dynamic>.from(element.value as Map<Object?, Object?>);
        printf('------------------->adnan$data');
        ReactionTestModel dataModel = ReactionTestModel.fromMap(data);
        // printf('----------->adnan 2$dataModel');
        reactionTestList.add(dataModel);
      }
      printf('total------>${reactionTestList.length}');

      if (reactionTestList.isNotEmpty) {
        late DateTime dateTime;
        DateFormat dateFormat = DateFormat("dd-MMM-yyyy HH:mm:ss");
        try {
          dateTime = dateFormat.parse(
              '${reactionTestList.last.dateTime} ${reactionTestList.last.reactionTestTime}');
        } catch (exe) {
          printf('--exe--date-time---->$exe');
        }
        var currentDate = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute, dateTime.second);

        takenAt = inputFormat.format(currentDate);

        slowest = reactionTestList.last.slowest.toString();
        fastest = reactionTestList.last.fastest.toString();
        average = reactionTestList.last.average.toString();
        accuracy = reactionTestList.last.accuracy.toString();

        vigilanceIndex = reactionTestList.last.vigilanceIndex.toString();

        cognitiveFlexibility =
            reactionTestList.last.cognitiveFlexibility.toString();

        falseStart = reactionTestList.last.falseStart.toString();
        lapses = reactionTestList.last.plusLapses.toString();

        pfs = reactionTestList.last.plusLapses.toString();

        resilience = reactionTestList.last.resilience.toString();
        printf('------resilience----->$resilience');

        performanceScore = reactionTestList.last.performanceScore.toString();
        printf('------performance-score----->$performanceScore');

        trendInsight = reactionTestList.last.trendInsight.toString();
        printf('---trend-insight----->$trendInsight');

        resilienceScore = reactionTestList.last.resilienceScore.toString();
        printf('------resilience-score2----->$resilienceScore');

        // var focusScore = reactionTestList.last.focusScore.toString();
        focusScore = reactionTestList.last.focusScore.toString();
        printf('------focus-score----->$focusScore');

        cognitiveSpeed = reactionTestList.last.speed.toString();
        printf('------cognitive-speed----->$cognitiveSpeed');

        // var flexibilityScore =
        //     reactionTestList.last.flexibilityScore.toString();
        flexibilityScore = reactionTestList.last.flexibilityScore.toString();
        printf('------flexibility-score----->$flexibilityScore');

        loaderHide();
        update([stateId]);
      }
    } else {
      printf('------record_not_found-------------');
      navigateToStartTest();
      loaderHide();
      update([stateId]);
    }
  }

  Future<void> getUserId() async {
    printf('<---get_user-id----->');
    try {
      userId = await Utility.getUserId();
      checkUserStatus(userId);

      printf('<--user-id------->$userId');
      update([stateId]);
    } catch (exe) {
      printf('<---exe-user-id--->$exe');
    }
  }

  void getUserDetails() {
    printf('<----call----getUserDetails---->');
    try {
      Utility.getUserDetails().then((value) {
        if (value != null) {
          userModel = value;
          username = userModel.name.toString();
          update([stateId]);
        }
      });
    } catch (e) {
      printf('<----exe-userDetails-->$e');
      getUsername();
    }
  }

  void getUsername() async {
    printf('<---get_username----->');
    try {
      username = await Utility.getUserName();
      printf('username---->$username');
      update([stateId]);
    } catch (exe) {
      printf('<---exe-username--->$exe');
    }
  }

  Future<void> navigateToStartTest() async {
    printf('<---navigate-to-StartTestScreen--->');
    final result = await Get.toNamed(Routes.startTestScreen);

    if (result != null) {
      getUserId().whenComplete(() {
        getReactionTestList();
      });
    }
  }

  // Future<void> navigateToReactionTest() async {
  //   printf('<---navigate-to-reactionTimeTestScreen--->');
  //   final result = await Get.toNamed(Routes.reactionTimeTestScreen);
  //
  //   if (result != null) {
  //     getReactionTestList();
  //   }
  // }

  void _showInactiveUserDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must close the dialog manually
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.inactiveAlertTitle),
          content: Text(AppStrings.inactiveAlertMessage),
          actions: <Widget>[
            TextButton(
              child: Text(AppStrings.inactiveAlertButton),
              onPressed: () {
                launchUrl(
                    Uri.parse(AppStrings.subscriptionUrl)); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> checkUserStatus(String userId) async {
    if (userId.isNotEmpty) {
      DataSnapshot snapshot = await databaseReference.child(userId).get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        String userStatus = data['status'] ?? 'inactive';
        if (userStatus == 'active') {
          Utility.setUserDetails(jsonEncode(data));
          update([stateId]);
          getUserDetails();
          print('<----User is active--->');
        } else {
          Utility.setUserDetails('');
          update([stateId]);
          print('<----User is inactive--->');
          _showInactiveUserDialog(Get.context!);
        }
      } else {
        print('<----User data does not exist--->');
        Utility().snackBarError('User not found or data is missing!');
      }
    } else {
      print('<----Invalid userId--->');
      Utility().snackBarError('Invalid user ID!');
    }
  }

  void callLogout() {
    Alerts.showAlertWithCancelAction(
      Get.context!,
      okTitle: AppStrings.ok,
      cancelTitle: AppStrings.cancel,
      () {
        Get.back();
        loaderShow();
        update([stateId]);
        AuthenticationHelper().signOut().whenComplete(() {
          printf('<---Logout---->');
          //Get.back();
          Utility().snackBarSuccess(AppStrings.successFullyLogout);
          Utility().clearSession();
          Get.deleteAll();
          Get.offAndToNamed(Routes.login);
          loaderHide();
        });
      },
      alertTitle: AppStrings.logout,
      alertMessage: AppStrings.logoutContent,
    );
  }
}

class ReactionTestModel {
  String? reactionTestTime;
  String? userId;
  String? dateTime;
  String? monthYear;
  String? accuracy;
  String? average;
  int? timeStamp;
  String? speed;
  String? plusLapses;
  String? fastest;
  String? slowest;
  String? falseStart;
  String? variation;
  String? isi0to2;
  String? isi2to4;
  String? slowingRate;
  String? performanceDecline;
  String? performanceScore;
  String? lpm;
  String? fpm;
  String? iqr;
  String? psr;
  String? rtrt;
  String? vigilanceIndex;
  String? alertness;
  String? resilience;
  String? fatigue;
  String? attention;
  String? cognitiveFlexibility;
  String? responseControl;
  String? cognitiveLoad;
  String? alertnessRating;
  String? supplementsTaken;
  String? trendInsight;
  double? resilienceScore;
  double? flexibilityScore;
  double? focusScore;
  List<ReactionTest>? reactionTest;

  ReactionTestModel({
    this.reactionTestTime,
    this.userId,
    this.dateTime,
    this.monthYear,
    this.accuracy,
    this.average,
    this.timeStamp,
    this.speed,
    this.plusLapses,
    this.fastest,
    this.slowest,
    this.falseStart,
    this.variation,
    this.isi0to2,
    this.isi2to4,
    this.slowingRate,
    this.performanceDecline,
    this.performanceScore,
    this.lpm,
    this.fpm,
    this.iqr,
    this.psr,
    this.rtrt,
    this.vigilanceIndex,
    this.alertness,
    this.resilience,
    this.fatigue,
    this.attention,
    this.cognitiveFlexibility,
    this.responseControl,
    this.cognitiveLoad,
    this.alertnessRating,
    this.supplementsTaken,
    this.trendInsight,
    this.resilienceScore,
    this.flexibilityScore,
    this.focusScore,
    this.reactionTest,
  });

  factory ReactionTestModel.fromMap(Map<String, dynamic> map) {
    return ReactionTestModel(
      reactionTestTime: map['reactionTestTime'] as String?,
      userId: map['userId'] as String?,
      dateTime: map['dateTime'] as String?,
      monthYear: map['monthYear'] as String?,
      accuracy: map['accuracy'] as String?,
      average: map['average'] as String?,
      timeStamp: map['timeStamp'] ?? 0,
      speed: map['speed'] as String?,
      plusLapses: map['plusLapses'] as String?,
      fastest: map['fastest'] as String?,
      slowest: map['slowest'] as String?,
      falseStart: map['falseStart'] as String?,
      variation: map['variation'] as String?,
      isi0to2: map["isi0to2"] as String?,
      isi2to4: map["isi2to4"] as String?,
      slowingRate: map["slowingRate"] as String?,
      performanceDecline: map["performanceDecline"] as String?,
      performanceScore: map["performanceScore"] as String?,
      lpm: map["lpm"] as String?,
      fpm: map["fpm"] as String?,
      iqr: map["iqr"] as String?,
      psr: map["psr"] as String?,
      rtrt: map["rtrt"] as String?,
      vigilanceIndex: map["vigilanceIndex"] as String?,
      alertness: map["alertness"] as String?,
      resilience: map["resilience"] as String?,
      fatigue: map["fatigue"] as String?,
      attention: map["attention"] as String?,
      cognitiveFlexibility: map["cognitiveFlexibility"] as String?,
      responseControl: map["responseControl"] as String?,
      cognitiveLoad: map["cognitiveLoad"] as String?,
      alertnessRating: map["alertnessRating"],
      supplementsTaken: map["supplementsTaken"],
      trendInsight: map["trendInsight"],
      resilienceScore: map["resilienceScore"],
      flexibilityScore: (map['flexibilityScore'] is int
          ? (map['flexibilityScore'] as int).toDouble()
          : map['flexibilityScore']) as double?,
      focusScore: (map['focusScore'] is int
          ? (map['focusScore'] as int).toDouble()
          : map['focusScore']) as double?,
      //flexibilityScore: map["flexibilityScore"],
      // focusScore: map["focusScore"],
      reactionTest: (map['reactionTest'] as List<dynamic>?)
          ?.map((item) => ReactionTest.fromMap(Map<String, dynamic>.from(item)))
          .toList(),
    );
  }
}

class ReactionTest {
  String? startTimeForGreenCard;
  int? randomTime;
  String? startTestTime;
  String? isTap;
  String? tapTimeForGreenCard;

  ReactionTest({
    this.startTimeForGreenCard,
    this.randomTime,
    this.startTestTime,
    this.isTap,
    this.tapTimeForGreenCard,
  });

  factory ReactionTest.fromMap(Map<String, dynamic> map) {
    return ReactionTest(
      startTimeForGreenCard: map['startTimeForGreenCard'] as String?,
      randomTime: map['randomTime'] ?? 0,
      startTestTime: map['startTestTime'] as String?,
      isTap: map['isTap'] as String?,
      tapTimeForGreenCard: map['tapTimeForGreenCard'] as String?,
    );
  }
}
