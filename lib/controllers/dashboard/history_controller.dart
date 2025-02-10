import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'dashboard_controller.dart';
import 'reaction_time_test_controller.dart';

class HistoryController extends BaseController {
  static String stateId = 'history_ui';
  BuildContext context;

  HistoryController(this.context);

  var displayDateText = '';

  List<ReactionTestModel> reactionTestList = [];
  List<ReactionTestModel> todayResults = [];
  var arguments = Get.arguments;
  var date = '';
  var userId = '';

  List<GraphModel> listForGraph = [];
  var formatter = DateFormat('dd-MMM-yyyy');
  var todayDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----HistoryController---------->');

      displayDateText = formatter.format(DateTime.now());

      printf('----today-date----->$displayDateText');

      if (arguments != null) {
        try {
          userId = arguments[0];
          reactionTestList = arguments[1];

          printf('<--userId---->$userId-->${reactionTestList.length}');

          getListOfReactionTest(
              userId: userId,
              date: displayDateText,
              totalRecords: reactionTestList);
        } catch (e) {
          printf('<----exe--->$e');
        }
      } else {
        printf('<----null-arguments------>');
      }

      update([stateId]);
    });
  }

  Future<void> getListOfReactionTest(
      {String? userId,
      String? date,
      List<ReactionTestModel>? totalRecords}) async {
    printf(
        '----userId-->$userId----date--->$date----total-records---->${totalRecords!.length}');
    if (totalRecords.isNotEmpty) {
      todayResults.clear();
      for (int i = 0; i < totalRecords.length; i++) {
        var record = totalRecords[i];
        //printf('----date--->${record.dateTime}');
        if (record.dateTime.toString() == date.toString()) {
          printf('today--data--->${record.average}');
          todayResults.add(record);
        }
      }
      todayResults = todayResults.reversed.toList();

      printf('<--------today---list---->${todayResults.length}');

      update([stateId]);
    } else {
      printf('<---no-today-result-found-------->');
    }
  }

  void previousDayTabClick() {
    late DateTime dateTime;
    try {
      dateTime = formatter.parse(displayDateText);
    } catch (exe) {
      printf('exe-$exe');
    }
    var prevDate = DateTime(dateTime.year, dateTime.month, dateTime.day - 1);
    displayDateText = formatter.format(prevDate);

    printf('---previous-dateTime--->$displayDateText');
    getListOfReactionTest(
        userId: userId, date: displayDateText, totalRecords: reactionTestList);
    update([stateId]);
  }

  void nextDayTabClick() {
    late DateTime dateTime;

    try {
      dateTime = formatter.parse(displayDateText);
    } catch (exe) {
      printf('exe-$exe');
    }

    if (formatter.format(todayDate) == displayDateText) {
      printf('Oops...next_day..');
    } else {
      var nextDate = DateTime(dateTime.year, dateTime.month, dateTime.day + 1);
      displayDateText = formatter.format(nextDate);
      getListOfReactionTest(
          userId: userId,
          date: displayDateText,
          totalRecords: reactionTestList);
    }

    printf('<----next---date--->$displayDateText');
    update([stateId]);
  }
}
