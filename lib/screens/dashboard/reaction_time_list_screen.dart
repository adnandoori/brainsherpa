import 'package:brainsherpa/controllers/dashboard/reaction_time_list_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/extension_classes.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/dashboard/dashboard_controller.dart';

class ReactionTimeListScreen extends StatelessWidget {
  const ReactionTimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  widgetAppBar(title: 'REACTION TIME'),
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
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.historyScreen, arguments: [
                              controller.userId,
                              controller.reactionTestList
                            ]);
                          },
                          child: Text(
                            AppStrings.viewHistory,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                color: Colors.grey,
                                decorationColor: Colors.grey,
                                decoration: TextDecoration.underline),
                          ),
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
                                            controller.todayResults.length,
                                        itemBuilder: (context, index) {
                                          return widgetReactionTime(
                                              controller.todayResults[index]);
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

  Widget widgetGraph(ReactionTimeListController controller) {
    return Container(
      width: Get.width,
      height: 300.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
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
            10.sbh,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
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
                        controller
                            .buttonNextWeekTab(controller.reactionTestList);
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
            10.sbh,
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
            dataSource: controller.graphDayList,
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
                shape: DataMarkerType.circle),
            xValueMapper: (GraphModelForDay sales, _) {
              return sales.xValue;
            },
            yValueMapper: (GraphModelForDay sales, _) => sales.yValue,
          ),
        ]);
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
              dataSource: controller.listWeekData,
              xValueMapper: (WeekModel sales, _) => DateFormat('dd-MMM-yyyy')
                  .format(DateTime.fromMillisecondsSinceEpoch(
                      int.parse(sales.title)))
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
              dataSource: controller.monthGraphPlot,
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

    var alertRate =
        data.alertnessRating != null ? data.alertnessRating.toString() : '0';

    var supplementsTaken =
        data.supplementsTaken != null ? data.supplementsTaken.toString() : 'No';

    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          16.sbh,
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStrings.takenAt} $takenAt',
                          style: poppinsTextStyle(
                            color: Colors.black,
                            size: 12.sp,
                          ),
                        ),
                        5.sbh,
                        Text(
                          'Alertness rating : $alertRate',
                          style: poppinsTextStyle(
                            color: Colors.black,
                            size: 12.sp,
                          ),
                        ),
                        5.sbh,
                        Text(
                          'Supplements taken : $supplementsTaken',
                          style: poppinsTextStyle(
                            color: Colors.black,
                            size: 12.sp,
                          ),
                        ),
                        5.sbh,
                        Text(
                          AppStrings.reactionTime,
                          style: poppinsTextStyle(
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        Text(
                          '(in ms)',
                          style: poppinsTextStyle(
                            color: Colors.black,
                            size: 14.sp,
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h, right: 16.w),
                      child: Text(
                        data.average.toString(),
                        style: poppinsTextStyle(
                          color: Colors.black,
                          size: 36.sp,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          35.sbh,
        ],
      ),
    );
  }
}
