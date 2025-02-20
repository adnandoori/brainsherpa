import 'package:brainsherpa/controllers/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brainsherpa/controllers/dashboard/reaction_time_list_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:brainsherpa/utils/extension_classes.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dashboardController = Get.put(DashboardController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: GetBuilder<ReactionTimeListController>(
          init: ReactionTimeListController(context),
          id: ReactionTimeListController.stateId,
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widgetAppBar(title: 'Performance Score'),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.todayResult,
                          style: poppinsTextStyle(
                              color: Colors.black,
                              size: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  10.sbh,
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                controller.todayResults.isNotEmpty
                                    ? ListView.builder(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount:
                                            1, // Only display the first item
                                        itemBuilder: (context, index) {
                                          return widgetReactionTime(controller
                                                  .todayResults[
                                              0]); // Always show the first item
                                        },
                                      )
                                    : SizedBox(
                                        height: 200.h,
                                        child: widgetNoRecordFound(),
                                      ),
                                10.sbh,
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    maxLines: 1,
                                    AppStrings.trends,
                                    style: poppinsTextStyle(
                                        color: Colors.black,
                                        size: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                20.sbh,
                                widgetGraph(controller),
                                20.sbh
                              ],
                            ),
                          )))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget widgetGraph(ReactionTimeListController controller) {
  // final dashboardController = Get.put(DashboardController());
  return Container(
    width: Get.width,
    height: 300.h,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: AppColors.white,
    ),
    child: DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            child: TabBar(
              dividerColor: Colors.transparent,
              controller: controller.tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              unselectedLabelStyle: poppinsTextStyle(
                  color: Colors.black,
                  size: 15.sp,
                  fontWeight: FontWeight.w600),
              labelStyle: poppinsTextStyle(
                  color: Colors.black,
                  size: 15.sp,
                  fontWeight: FontWeight.w600),
              onTap: (index) {},
              tabs: const [
                Tab(
                  text: AppStrings.day,
                ),
                Tab(text: AppStrings.week),
                Tab(text: AppStrings.month),
              ],
            ),
          ),
          // 10.sbh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (controller.tabController.index == 1) {
                      controller
                          .buttonPreviousWeekTab(controller.reactionTestList);
                    } else if (controller.tabController.index == 2) {
                      controller.buttonPreviousMonthTab();
                    } else {
                      controller.previousDayTabClick();
                    }
                  },
                  child: Image.asset(
                    ImagePath.icBack,
                    height: 16.w,
                    width: 16.w,
                  ),
                ),
                InkWell(
                  onTap: controller.tabController.index == 0
                      ? () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: Get.context!,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (pickedDate != null) {
                            controller.selectDate(pickedDate);
                          }
                        }
                      : null,
                  child: Text(
                    controller.tabController.index == 1
                        ? controller.weekDate.toString()
                        : controller.tabController.index == 2
                            ? controller.displayMonthText.toString()
                            : controller.displayDateText.toString(),
                    style: poppinsTextStyle(
                        size: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (controller.tabController.index == 1) {
                      controller.buttonNextWeekTab(controller.reactionTestList);
                    } else if (controller.tabController.index == 2) {
                      controller.buttonNextMonthTab();
                    } else {
                      controller.nextDayTabClick();
                    }
                  },
                  child: Image.asset(
                    ImagePath.icNextDate,
                    height: 16.w,
                    width: 16.w,
                  ),
                ),
              ],
            ),
          ),
          // 10.sbh,
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                widgetDay(controller),
                widgetWeek(controller),
                widgetMonth(controller),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget widgetDay(ReactionTimeListController controller) {
  return SfCartesianChart(
    primaryXAxis: const CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
    ),
    legend: const Legend(isVisible: false),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CartesianSeries<GraphModelForDay, String>>[
      SplineSeries<GraphModelForDay, String>(
        enableTooltip: false,
        color: AppColors.blueColor,
        dataSource: controller.graphDayListForPerformanceScore,
        width: 4,
        dataLabelSettings:
            const DataLabelSettings(showZeroValue: true, isVisible: true),
        markerSettings: const MarkerSettings(
          borderWidth: 5.0,
          color: Colors.white,
          isVisible: true,
          height: 5,
          width: 5,
          borderColor: AppColors.blueColor,
          shape: DataMarkerType.circle,
        ),
        xValueMapper: (GraphModelForDay sales, _) {
          return sales.xValue;
        },
        // Map to performanceScore instead of reactionTime
        yValueMapper: (GraphModelForDay sales, _) => sales.yValue,
      ),
    ],
  );
}

Widget widgetWeek(ReactionTimeListController controller) {
  return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      legend: const Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ColumnSeries<WeekModel, String>>[
        ColumnSeries<WeekModel, String>(
            enableTooltip: false,
            color: AppColors.blueColor,
            dataSource: controller.PerformanceScorelWeekData,
            xValueMapper: (WeekModel sales, _) => DateFormat('dd-MMM-yyyy')
                .format(
                    DateTime.fromMillisecondsSinceEpoch(int.parse(sales.title)))
                .toString()
                .substring(0, 2),
            yValueMapper: (WeekModel sales, _) {
              if (sales.count > 0) {
                double avg = sales.value / sales.count;
                return avg.toInt();
              } else {
                return sales.value;
              }
            },
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ]);
}

Widget widgetMonth(ReactionTimeListController controller) {
  return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      legend: const Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ColumnSeries<GraphModelForDay, String>>[
        ColumnSeries<GraphModelForDay, String>(
            enableTooltip: false,
            color: AppColors.blueColor,
            dataSource: controller.monthGraphPlotForPerformanceScore,
            xValueMapper: (GraphModelForDay sales, _) => sales.xValue,
            yValueMapper: (GraphModelForDay sales, _) => sales.yValue,
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ]);
}

Widget widgetReactionTime(ReactionTestModel data) {
  late DateTime dateTime;
  DateFormat inputFormat = DateFormat("HH:mm dd-MM-yyyy");
  DateFormat dateFormat = DateFormat("dd-MMM-yyyy HH:mm:ss");
  try {
    dateTime = dateFormat.parse('${data.dateTime} ${data.reactionTestTime}');
  } catch (exe) {
    printf('--exe--date-time---->$exe');
  }
  var currentDate = DateTime(dateTime.year, dateTime.month, dateTime.day,
      dateTime.hour, dateTime.minute, dateTime.second);

  var takenAt = inputFormat.format(currentDate);

  var performanceScore =
      data.performanceScore != null ? data.performanceScore.toString() : '0';

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Performance Score',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          child: Row(
            children: [
              Text(
                '$performanceScore',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
