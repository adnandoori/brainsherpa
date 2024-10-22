import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/fcm/authentication_helper.dart';
import 'package:brainsherpa/models/authentication_model/user_model.dart';
import 'package:brainsherpa/models/dashboard_models/reaction_test_model.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:brainsherpa/widgets/alert_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends BaseController {
  static String stateId = 'dashboard_ui';

  var userId = '';
  var username = '';
  late UserModel userModel;

  var takenAt = '0';
  var fastest = '0';
  var slowest = '0';

  var average = '0';

  DatabaseReference dbReactionTest =
      FirebaseDatabase.instance.ref().child(AppConstants.reactionTestTable);

  List<ReactionTestModel> reactionTestList = [];

  DateFormat inputFormat = DateFormat("HH:mm dd-MM-yyyy");

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----DashboardController---->');
      getUserDetails();
      getUserId().whenComplete(() {
        getReactionTestList();
      });
    });
  }

  Future<void> getReactionTestList() async {
    loaderShow();
    update([stateId]);
    DataSnapshot snapshot = await dbReactionTest.child(userId).get();

    if (snapshot.children.isNotEmpty) {
      for (var element in snapshot.children) {
        final data =
            Map<String, dynamic>.from(element.value as Map<Object?, Object?>);
        ReactionTestModel dataModel = ReactionTestModel.fromMap(data);
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
      }

      loaderHide();
      update([stateId]);
    } else {
      printf('------record_not_found-------------');
      loaderHide();
      update([stateId]);
    }
  }

  Future<void> getUserId() async {
    printf('<---get_user-id----->');
    try {
      userId = await Utility.getUserId();
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

  Future<void> navigateToReactionTest() async {
    printf('<---navigate-to-reactionTimeTestScreen--->');
    final result = await Get.toNamed(Routes.reactionTimeTestScreen);

    if (result != null) {
      getReactionTestList();
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
          Get.offNamedUntil(Routes.login, (route) => false);
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
      speed: map['speed'] as String,
      plusLapses: map['plusLapses'] as String?,
      fastest: map['fastest'] as String?,
      slowest: map['slowest'] as String?,
      falseStart: map['falseStart'] as String?,
      variation: map['variation'] as String,
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
