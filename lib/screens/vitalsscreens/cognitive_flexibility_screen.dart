import 'package:brainsherpa/controllers/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brainsherpa/controllers/dashboard/reaction_time_list_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CognitiveFlexibilityScreen extends StatelessWidget {
  const CognitiveFlexibilityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widgetAppBar(title: 'Cognitive Flexibility'),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: widgetGraph(controller),
                        ),
                      ],
                    ),
                  );
                })));
  }
}

Widget widgetGraph(ReactionTimeListController controller) {
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
                // widgetWeek(controller),
                // widgetMonth(controller),
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
