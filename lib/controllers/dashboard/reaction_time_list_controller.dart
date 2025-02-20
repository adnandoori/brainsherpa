import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'dashboard_controller.dart';

class ReactionTimeListController extends BaseController
    with GetSingleTickerProviderStateMixin {
  static String stateId = 'reaction_time_list_ui';
  BuildContext context;

  ReactionTimeListController(this.context);

  DateTime today = DateTime.now().toUtc();

// List Values
  List<ReactionTestModel> reactionTestList = [];
  List<ReactionTestModel> todayResults = [];
  List<GraphModelForDay> graphDayListForPerformanceScore = [];
  List<GraphModelForDay> graphDayList = [];
  List<ReactionTestModel> weekReactionTestList = [];
  List<GraphModelForDay> weekNumbers = [];
  List<GraphModelForDay> weekNumberReversed = [];
  List<String> weekDateList = [];
  List<WeekModel> listWeekData = [];
  List<WeekModel> PerformanceScorelWeekData = [];
  List<DateTime> weekList = [];
  List<GraphModelForDay> monthGraphPlot = [];
  List<ReactionTestModel> monthReactionTestList = [];
  List<WeekOfMonthModel> weekOfMonth = [];
  List<GraphModelForDay> monthGraphPlotForPerformanceScore = [];

// Var Values
  var todayDate = DateTime.now();
  var formatter = DateFormat('dd-MMM-yyyy');
  var date = '';
  var userId = '';
  var currentMonth = DateTime.now();
  var arguments = Get.arguments;
  var weekDate = '';
  var currentWeek = DateTime.now();
  var formatterWeek = DateFormat('dd-MMM-yyyy');
  var displayWeekText = '';
  var formatterMonth = DateFormat(' MMM, yyyy');
  var displayMonthText = '';
  var displayDateText = '';

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.reactionTestTable);
  late TabController tabController = TabController(length: 3, vsync: this);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----ReactionTimeListController---------->');
      date = formatter.format(todayDate);
      if (arguments != null) {
        try {
          userId = arguments[0];
          reactionTestList = arguments[1];
          // printf('<--reactionTestList---->${reactionTestList}');

          printf('<--userId---->$userId-->${reactionTestList.length}');
          //date = '23-Oct-2024';

          displayDateText = formatter.format(todayDate);
          displayWeekText = formatterWeek.format(currentWeek);
          displayMonthText = formatterMonth.format(currentMonth);

          printf('<----displayDateText----->$displayDateText');

          getListOfReactionTest(
              userId: userId, date: date, totalRecords: reactionTestList);
          printf('$reactionTestList');
        } catch (e) {
          printf('<----exe--->$e');
        }
      }

      tabController.addListener(() {
        printf('tabIndexGraph-${tabController.index}');
        update([stateId]);
      });
    });
  }

  void selectDate(pickedDate) {
    String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
    displayDateText = formattedDate;
    printf('---selected-date-->$formattedDate');
    update([stateId]);
    selectedDateRecord(displayDateText);
  }

  void selectedDateRecord(displayDateText) {
    late DateTime dateTime;
    try {
      dateTime = formatter.parse(displayDateText);
    } catch (exe) {
      printf('exe-$exe');
    }
    var prevDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    displayDateText = formatter.format(prevDate);

    printf('selected---date----$displayDateText----');
    //reactionTestList = reactionTestList.reversed.toList();
    getResultForDay(date: displayDateText, list: reactionTestList);

    update([stateId]);
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
        if (record.dateTime.toString() == date.toString()) {
          printf('today--data--->${record.average}');
          printf('today--data--->${record.performanceScore}');
          todayResults.add(record);
        }
      }
      todayResults = todayResults.reversed.toList();
      printf('$todayResults');
      // printf('------------------------todays results>$todayResults');

      getResultForDay(date: date.toString(), list: reactionTestList);

      getCurrentWeekForFirstTime(today, reactionTestList);
      printf('--current-month--->$currentMonth');
      getMonthDataForFirstTime(currentMonth, reactionTestList);
      update([stateId]);
    } else {
      printf('<---no-today-result-found-------->');
    }
  }

  void getResultForDay(
      {required String date, required List<ReactionTestModel> list}) {
    printf('------getResultForDay----->$date----->$list');
    printf('-----------?data --->$list');

    graphDayList.clear();
    graphDayListForPerformanceScore.clear();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        var record = list[i];

        if (record.dateTime.toString() == date.toString()) {
          double y = double.parse(record.average.toString()).toDouble();

          double performanceScore =
              double.parse(record.performanceScore.toString()).toDouble();
          DateTime parsedTime =
              DateFormat("HH:mm:ss").parse(record.reactionTestTime.toString());

          // String formattedTime = DateFormat("HH:mm").format(parsedTime);
          String formattedTime = DateFormat("HH:mm").format(parsedTime);
          // printf('-----------Adnan>$formattedTime');

          graphDayList.add(GraphModelForDay(formattedTime, y));
          graphDayListForPerformanceScore
              .add(GraphModelForDay(formattedTime, performanceScore));
        }
      }
      // graphDayList = graphDayList.reversed.toList();
      update([stateId]);
    } else {
      printf('<-----no-record-found-for-day-------->');
    }
  }

  void getPerformanceScoreForDay(
      {required String date, required List<ReactionTestModel> list}) {
    printf('------getPerformanceScoreForDay----->$date----->${list.length}');
    graphDayListForPerformanceScore.clear();

    if (list.isNotEmpty) {
      for (var record in list) {
        if (record.dateTime.toString() == date.toString()) {
          double y =
              double.parse(record.performanceScore.toString()).toDouble();
          DateTime parsedTime =
              DateFormat("HH:mm:ss").parse(record.reactionTestTime.toString());

          String formattedTime = DateFormat("HH:mm").format(parsedTime);
          graphDayListForPerformanceScore
              .add(GraphModelForDay(formattedTime, y));
        }
      }
      update([stateId]);
    } else {
      printf('<-----no-record-found-for-performance-score-------->');
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
    selectedDateRecord(displayDateText);
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
      selectedDateRecord(displayDateText);
    }

    printf('<----next---date--->$displayDateText');
    update([stateId]);
  }

  void buttonPreviousWeekTab(totalAllRecords) {
    late DateTime dateTime;

    try {
      dateTime = formatterWeek.parse(displayWeekText);
    } catch (exe) {
      printf('exe-$exe');
    }

    var currentDate = DateTime(dateTime.year, dateTime.month, dateTime.day - 7);
    displayWeekText = formatterWeek.format(currentDate);
    printf('<----datePreviousWeek---->$displayWeekText');
    if (weekList.isNotEmpty) {
      getPreviousWeekDataForOneTime(weekList.last, reactionTestList);
      getWeekData(weekReactionTestList);
    }
    update([stateId]);
  }

  void buttonNextWeekTab(totalAllRecords) {
    late DateTime dateTime;

    try {
      dateTime = formatterWeek.parse(displayWeekText);
    } catch (exe) {
      printf('<---exe---buttonNextWeekTab-->$exe');
    }

    printf('----->$displayWeekText----->$displayDateText');

    if (displayWeekText == displayDateText) {
      printf('Oops...next_week..');
    } else {
      var currentDate =
          DateTime(dateTime.year, dateTime.month, dateTime.day + 7);
      displayWeekText = formatterWeek.format(currentDate);
      printf('<----dateTimeWeek----->$displayWeekText');

      getNextWeekDataForOneTime(currentDate, reactionTestList);
    }

    update([stateId]);
  }

  void buttonPreviousMonthTab() {
    late DateTime dateTime;

    try {
      dateTime = formatterMonth.parse(displayMonthText);
    } catch (exe) {
      printf('exe-$exe');
    }
    var currentDate = DateTime(dateTime.year, dateTime.month - 1, dateTime.day);
    displayMonthText = formatterMonth.format(currentDate);
    printf('<-----dateTimeMonth--->$displayMonthText');
    getMonthDataForFirstTime(currentDate, reactionTestList);
    update([stateId]);
  }

  void buttonNextMonthTab() {
    late DateTime dateTime;
    try {
      dateTime = formatterMonth.parse(displayMonthText);
    } catch (exe) {
      printf('exe-$exe');
    }

    if (todayDate.month == dateTime.month) {
      return;
    }
    var currentDate = DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
    displayMonthText = formatterMonth.format(currentDate);
    printf('<-----dateTimeNextMonth----->$displayMonthText');
    getMonthDataForFirstTime(currentDate, reactionTestList);
    update([stateId]);
  }

  void getMonthDataForFirstTime(
      DateTime selectedMonth, List<ReactionTestModel> totalAllRecords) {
    weekOfMonth = [];
    monthReactionTestList = [];
    monthGraphPlot = [];
    monthGraphPlotForPerformanceScore = [];

    selectedMonth ??= DateTime.now();

    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month,
        selectedMonth.day, 0, 0, 0, 0, 0);

    DateTime firstDateOfMonth = findFirstDateOfTheMonth(selectedMonth);
    DateTime lastDateOfMonth = findLastDateOfTheMonth(selectedMonth);

    prepareWeeksOfMonthData(firstDateOfMonth, lastDateOfMonth);

    DateTime endDt = lastDateOfMonth.add(const Duration(days: 1));
    DateTime startDt = firstDateOfMonth.subtract(const Duration(days: 1));

    printf(
        'Fetching month data from ${DateFormat('dd-MMM-yyyy').format(startDt)} to ${DateFormat('dd-MMM-yyyy').format(endDt)}');

    monthReactionTestList = totalAllRecords
        .where((item) =>
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isAfter(startDt) &&
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isBefore(endDt))
        .toList();

    if (monthReactionTestList.isNotEmpty) {
      monthReactionTestList
          .sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));

      var groupByDate = groupBy(monthReactionTestList, (obj) => obj.dateTime);

      groupByDate.forEach((date, list) {
        double sumReactionTime = 0;
        double sumPerformanceScore = 0;

        for (var listItem in list) {
          sumReactionTime += double.tryParse(listItem.average ?? "0") ?? 0;
          sumPerformanceScore +=
              double.tryParse(listItem.performanceScore ?? "0") ?? 0;
        }

        double avgReactionTime = sumReactionTime / list.length;
        double avgPerformanceScore = sumPerformanceScore / list.length;

        DateTime recordDate =
            DateTime.fromMillisecondsSinceEpoch(list.first.timeStamp!);

        var filterData = weekOfMonth
            .where((itemFound) => isBetweenDate(
                recordDate, itemFound.weekStartDate!, itemFound.weekEndDate!))
            .toList();

        for (var item in filterData) {
          item.avgMeasure = avgReactionTime;
          item.avgMeasurePerformanceScore = avgPerformanceScore;
        }
      });

      for (int i = 0; i < weekOfMonth.length; i++) {
        double reactionTime = weekOfMonth[i].avgMeasure ?? 0;
        double performanceScore =
            weekOfMonth[i].avgMeasurePerformanceScore ?? 0;

        monthGraphPlot[i].yValue = reactionTime.roundToDouble();
        monthGraphPlotForPerformanceScore.add(GraphModelForDay(
            'Week ${weekOfMonth[i].weekOfYear}',
            performanceScore.roundToDouble()));
      }

      update([stateId]);
    } else {
      printf('<-------No month records found--------->');
      update([stateId]);
    }
  }

  void getCurrentWeekForFirstTime(
      DateTime dateTime, List<ReactionTestModel> totalAllRecords) {
    weekNumbers.clear();
    weekDateList.clear();
    listWeekData.clear();
    weekList.clear();
    DateTime dt;
    for (int i = 0; i < 8; i++) {
      dt = dateTime.subtract(Duration(days: i));
      weekNumbers.add(GraphModelForDay(DateFormat('dd').format(dt), 33));
      weekDateList.add(DateFormat('dd-MMM-yyyy').format(dt));
      PerformanceScorelWeekData.add(
          WeekModel(dt.millisecondsSinceEpoch.toString(), 0.0, 0));
      listWeekData.add(WeekModel(dt.millisecondsSinceEpoch.toString(), 0.0, 0));
      weekList.add(dt);

      //printf('weekListDate-${DateFormat('dd-MMM-yyyy HH:mm:ss').format(dt)} - ${dt.millisecondsSinceEpoch}');
    }
    weekNumberReversed = weekNumbers.reversed.toList();

    weekDate = '${formatter.format(weekList.last)}-${formatter.format(today)}';

    DateTime endDt = DateTime.now().subtract(const Duration(days: 0));
    DateTime startDt = DateTime.now().subtract(const Duration(days: 7));

    printf('-->${DateFormat('dd-MMM-yyyy').format(startDt)}--->'
        '${DateFormat('dd-MMM-yyyy').format(endDt)}');

    weekReactionTestList = totalAllRecords
        .where((item) =>
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isAfter(startDt) &&
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isBefore(endDt))
        .toList();

    printf(
        '--------week---list---->${weekReactionTestList.length}---->date--->$weekDate');

    if (weekReactionTestList.isNotEmpty) {
      getWeekData(weekReactionTestList);
    }
  }

  void getPreviousWeekDataForOneTime(
      DateTime dateTime, List<ReactionTestModel> totalAllRecords) {
    weekList.clear();
    weekNumbers.clear();
    weekDateList.clear();
    listWeekData.clear();

    DateTime dt;
    for (int i = 0; i < 8; i++) {
      dt = dateTime.subtract(Duration(days: i));
      weekNumbers.add(GraphModelForDay(DateFormat('dd').format(dt), 33.0 + i));
      weekDateList.add(DateFormat('dd-MMM-yyyy').format(dt));
      listWeekData.add(WeekModel(dt.millisecondsSinceEpoch.toString(), 0.0, 0));
      var date = DateTime(dt.year, dt.month, dt.day, 0, 0, 0, 0, 0);
      weekList.add(date);
    }
    weekNumberReversed = weekNumbers.reversed.toList();
    weekDate =
        '${formatter.format(weekList.last)}-${formatterWeek.format(weekList.first)}';

    printf('weekDate->$weekDate');

    DateTime endDt = DateTime.fromMillisecondsSinceEpoch(
            weekList.last.millisecondsSinceEpoch)
        .subtract(const Duration(days: 1));
    DateTime startDt = DateTime.fromMillisecondsSinceEpoch(
            weekList.first.millisecondsSinceEpoch)
        .add(const Duration(days: 1));

    printf('start-->${DateFormat('dd-MMM-yyyy').format(endDt)}--->'
        '${DateFormat('dd-MMM-yyyy').format(startDt)}');

    weekReactionTestList = totalAllRecords
        .where((item) =>
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isAfter(endDt) &&
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isBefore(startDt))
        .toList();

    if (weekReactionTestList.isNotEmpty) {
      getWeekData(weekReactionTestList);
    }

    update([stateId]);
  }

  void getNextWeekDataForOneTime(
      DateTime dateTime, List<ReactionTestModel> totalAllRecords) {
    weekList.clear();
    weekNumbers.clear();
    weekDateList.clear();
    listWeekData.clear();

    DateTime dt;
    for (int i = 0; i < 8; i++) {
      dt = dateTime.subtract(Duration(days: i));
      weekNumbers.add(GraphModelForDay(DateFormat('dd').format(dt), 33.0 - i));
      weekDateList.add(DateFormat('dd-MMM-yyyy').format(dt));
      listWeekData.add(WeekModel(dt.millisecondsSinceEpoch.toString(), 0.0, 0));

      weekNumbers.reversed;
      var date = DateTime(dt.year, dt.month, dt.day, 0, 0, 0, 0, 0);
      weekList.add(date);
    }

    weekNumberReversed = weekNumbers.reversed.toList();
    weekDate =
        '${formatter.format(weekList.last)}-${formatterWeek.format(weekList.first)}';

    printf('weekDateNext->$weekDate');

    DateTime endDt = DateTime.fromMillisecondsSinceEpoch(
            weekList.last.millisecondsSinceEpoch)
        .subtract(const Duration(days: 1));
    DateTime startDt = DateTime.fromMillisecondsSinceEpoch(
            weekList.first.millisecondsSinceEpoch)
        .add(const Duration(days: 1));

    printf('start-->${DateFormat('dd-MMM-yyyy').format(endDt)}--->'
        '${DateFormat('dd-MMM-yyyy').format(startDt)}');

    weekReactionTestList = totalAllRecords
        .where((item) =>
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isAfter(endDt) &&
            DateTime.fromMillisecondsSinceEpoch(item.timeStamp!)
                .isBefore(startDt))
        .toList();

    if (weekReactionTestList.isNotEmpty) {
      getWeekData(weekReactionTestList);
    }

    update([stateId]);
  }

  void getWeekData(List<ReactionTestModel> weekReactionTestList) {
    printf("getWeekData called with ${weekReactionTestList.length} records.");

    var resultFormatter = DateFormat('dd-MMM-yyyy');

    if (weekReactionTestList.isNotEmpty) {
      List<WeekModel> tempListWeekData = [];
      List<WeekModel> tempPerformanceScoreData = [];

      for (var e in weekReactionTestList) {
        var dateTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(e.timeStamp.toString()));
        String formattedDate = resultFormatter.format(dateTime);

        printf("Processing record for date: $formattedDate");
        printf("Performance Score from record: ${e.performanceScore}");

        if (weekDateList.contains(formattedDate)) {
          printf("Match found in weekDateList for $formattedDate");

          // Update reaction time
          int index = tempListWeekData.indexWhere((element) =>
              resultFormatter.format(DateTime.fromMillisecondsSinceEpoch(
                  int.parse(element.title.toString()))) ==
              formattedDate);

          if (index != -1) {
            double avgValue = tempListWeekData[index].value +
                double.parse(e.average.toString());
            int count = tempListWeekData[index].count;

            tempListWeekData.removeAt(index);
            tempListWeekData
                .add(WeekModel(e.timeStamp.toString(), avgValue, count + 1));
          } else {
            tempListWeekData.add(WeekModel(
                e.timeStamp.toString(), double.parse(e.average.toString()), 1));
          }

          // Update PerformanceScorelWeekData
          double parsedScore =
              double.tryParse(e.performanceScore.toString()) ?? 0;
          printf("Parsed Performance Score: $parsedScore");

          index = tempPerformanceScoreData.indexWhere((element) =>
              resultFormatter.format(DateTime.fromMillisecondsSinceEpoch(
                  int.parse(element.title.toString()))) ==
              formattedDate);

          if (index != -1) {
            double avgScore =
                tempPerformanceScoreData[index].value + parsedScore;
            int countScore = tempPerformanceScoreData[index].count;

            tempPerformanceScoreData.removeAt(index);
            tempPerformanceScoreData.add(
                WeekModel(e.timeStamp.toString(), avgScore, countScore + 1));
          } else {
            tempPerformanceScoreData
                .add(WeekModel(e.timeStamp.toString(), parsedScore, 1));
          }
        }
      }

      // Sort lists in ascending order (oldest first)
      tempListWeekData
          .sort((a, b) => int.parse(a.title).compareTo(int.parse(b.title)));
      tempPerformanceScoreData
          .sort((a, b) => int.parse(a.title).compareTo(int.parse(b.title)));

      listWeekData = tempListWeekData;
      PerformanceScorelWeekData = tempPerformanceScoreData;
    } else {
      printf("No data found for this week.");
      listWeekData = [];
      PerformanceScorelWeekData = [];
    }

    printf("Final listWeekData: $listWeekData");
    printf("Final PerformanceScorelWeekData: $PerformanceScorelWeekData");

    update([stateId]);
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  ///Return FIRST DAY OF THE MONTH
  ///
  ///
  ///
  DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    DateTime firstDayOfMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfMonth;
  }

  /// Return  LAST DAY OF THE MONTH
  ///
  ///
  DateTime findLastDateOfTheMonth(DateTime dateTime) {
    DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
    return lastDayOfMonth;
  }

  void prepareWeeksOfMonthData(DateTime firstDate, DateTime lastDate) {
    DateTime weekLastDate = DateTime(firstDate.year, firstDate.month,
        firstDate.day + (7 - firstDate.weekday), 0, 0, 0, 0, 0);

    if (weekLastDate.isBefore(lastDate)) {
      weekOfMonth.add(WeekOfMonthModel(
          month: firstDate.month,
          weekOfYear: weekNumber(firstDate),
          weekStartDate: firstDate,
          weekEndDate: weekLastDate,
          avgMeasure: 0));

      // printf("Adding New Week :${weekOfMonth.last.weekOfYear} ${weekOfMonth.last.weekStartDate} to ${weekOfMonth.last.weekEndDate}");

      DateTime nextWeekFirstDate = DateTime(firstDate.year, firstDate.month,
          firstDate.day + (7 - firstDate.weekday) + 1, 0, 0, 0, 0, 0);

      if (nextWeekFirstDate.isBefore(lastDate) ||
          nextWeekFirstDate.isAtSameMomentAs(lastDate)) {
        prepareWeeksOfMonthData(nextWeekFirstDate, lastDate);
      } else {
        printf("Forbidden DateTime $nextWeekFirstDate");
      }
    } else {
      weekOfMonth.add(WeekOfMonthModel(
          month: firstDate.month,
          weekOfYear: weekNumber(firstDate),
          weekStartDate: firstDate,
          weekEndDate: lastDate));

      // printf("Adding New Week :${weekOfMonth.last.weekOfYear} ${weekOfMonth.last.weekStartDate} to ${weekOfMonth.last.weekEndDate}");
    }
    monthGraphPlot = [];
    for (int i = 0; i < weekOfMonth.length; i++) {
      var element = weekOfMonth[i];
      monthGraphPlot.add(GraphModelForDay('Week${element.weekOfYear}', 0));
    }
    update([stateId]);
  }

  isBetweenDate(DateTime recordDate, DateTime dateTime1, DateTime dateTime2) {
    if (recordDate.isAtSameMomentAs(dateTime1)) {
      return true;
    } else if (recordDate.isAtSameMomentAs(dateTime2)) {
      return true;
    } else if (recordDate.isAfter(dateTime1) &&
        recordDate.isBefore(dateTime2)) {
      return true;
    } else {
      return false;
    }
  }
}

class GraphModelForDay {
  GraphModelForDay(this.xValue, this.yValue);

  final String xValue;
  double yValue;
}

class WeekModel {
  WeekModel(this.title, this.value, this.count);

  final String title;
  final double value;
  final int count;
}

class WeekOfMonthModel {
  WeekOfMonthModel(
      {this.month,
      this.weekOfYear,
      this.weekStartDate,
      this.weekEndDate,
      this.avgMeasure,
      this.avgMeasurePerformanceScore});

  int? month;
  int? weekOfYear;
  DateTime? weekStartDate;
  DateTime? weekEndDate;
  double? avgMeasure;
  double? avgMeasurePerformanceScore;
}
