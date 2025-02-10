import 'package:brainsherpa/controllers/dashboard/dashboard_controller.dart';
import 'package:brainsherpa/controllers/dashboard/history_controller.dart';
import 'package:brainsherpa/controllers/dashboard/reaction_time_test_controller.dart';
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

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: GetBuilder<HistoryController>(
          init: HistoryController(context),
          id: HistoryController.stateId,
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widgetAppBar(title: AppStrings.history),
                  10.sbh,
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.previousDayTabClick();
                          },
                          child: Image.asset(
                            ImagePath.icBack,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: Get.context!,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {}
                          },
                          child: Text(
                            controller.displayDateText.toString(),
                            style: poppinsTextStyle(
                                size: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.nextDayTabClick();
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
                    child: controller.todayResults.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: controller.todayResults.length,
                              itemBuilder: (context, index) {
                                return widgetReactionTime(
                                    controller.todayResults[index]);
                              },
                            ),
                          )
                        : widgetNoRecordFound(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
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
    List<GraphModel> listForGraph = [];
    if (data.reactionTest!.isNotEmpty) {
      for (int i = 0; i < data.reactionTest!.length; i++) {
        int diff = int.parse(
                data.reactionTest![i].tapTimeForGreenCard.toString()) -
            int.parse(data.reactionTest![i].startTimeForGreenCard.toString());

        int? randomTime = data.reactionTest![i].randomTime;

        listForGraph.add(GraphModel(randomTime.toString(), diff));

        //printf('----difference-for-time-test---->$diff---random-time-->$randomTime');
      }
    }

    double max = double.parse(data.slowest.toString()) + 100;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.sbh,
          Row(
            children: [
              Expanded(
                  flex: 7,
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
                        20.sbh,
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
                  flex: 3,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                      ),
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
          10.sbh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.fastest} (in ms):',
                  style: poppinsTextStyle(
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
                Text(
                  data.fastest.toString(),
                  style: poppinsTextStyle(
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          4.sbh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.slowest} (in ms):',
                  style: poppinsTextStyle(
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
                Text(
                  data.slowest.toString(),
                  style: poppinsTextStyle(
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          16.sbh,
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              height: 180.h,
              width: Get.width,
              child: widgetGraph(listForGraph, data.average, max)),
          Container(
            margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      data.speed.toString(),
                      style: poppinsTextStyle(
                          color: Colors.black,
                          size: 23.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    6.sbh,
                    Text(
                      AppStrings.speed,
                      style: poppinsTextStyle(
                          color: Colors.black,
                          size: 12.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
                Container(
                  width: 1,
                  height: 64.h,
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      data.variation.toString(),
                      style: poppinsTextStyle(
                          color: Colors.black,
                          size: 23.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    6.sbh,
                    Text(
                      AppStrings.variation,
                      style: poppinsTextStyle(
                          color: Colors.black,
                          size: 12.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
                Container(
                  width: 1,
                  height: 64.h,
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      data.accuracy.toString(),
                      style: poppinsTextStyle(
                          color: Colors.black,
                          size: 23.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    6.sbh,
                    Text(
                      AppStrings.performance,
                      textAlign: TextAlign.center,
                      style: poppinsTextStyle(
                          color: Colors.black,
                          size: 12.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
              ],
            ),
          ),
          20.sbh,
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Text(
              'Alertness rating : $alertRate',
              style: poppinsTextStyle(
                color: Colors.black,
                size: 12.sp,
              ),
            ),
          ),
          5.sbh,
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Text(
              'Supplements taken : $supplementsTaken',
              style: poppinsTextStyle(
                color: Colors.black,
                size: 12.sp,
              ),
            ),
          ),
          25.sbh,
        ],
      ),
    );
  }

  Widget widgetGraph(listForGraph, avg, max) {
    return SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'Elapsed Time (secs)'),
          //controller.maximumValue,
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(color: Colors.transparent),
          minimum: max,
          maximum: 0,
          isInversed: true,
          plotBands: <PlotBand>[
            const PlotBand(
                horizontalTextAlignment: TextAnchor.start,
                start: 0,
                end: 200,
                //max,
                opacity: 0.1,
                color: Colors.red,
                dashArray: <double>[4, 5]),
            PlotBand(
                horizontalTextAlignment: TextAnchor.start,
                start: 400,
                end: max,
                opacity: 0.1,
                color: Colors.red,
                dashArray: const <double>[4, 5]),
          ],
          isVisible: true,
          labelStyle: const TextStyle(fontSize: 8, color: Color(0xFF929395)),
        ),
        legend: const Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          SplineSeries<GraphModel, String>(
              color: AppColors.blueColor,
              markerSettings: const MarkerSettings(
                isVisible: true,
                color: AppColors.blueColor,
                borderColor: AppColors.blueColor,
                shape: DataMarkerType.circle,
                width: 5,
                height: 5,
              ),
              dataLabelSettings: const DataLabelSettings(
                  textStyle: TextStyle(fontSize: 9, color: Color(0xFF0080FF)),
                  showZeroValue: false,
                  isVisible: false),
              dataSource: listForGraph,
              trendlines: <Trendline>[
                Trendline(type: TrendlineType.linear, color: Colors.black)
              ],
              xValueMapper: (GraphModel data, _) => data.title,
              yValueMapper: (GraphModel data, _) => data.value),
        ]);
    // return SfCartesianChart(
    //     primaryXAxis: const CategoryAxis(
    //       majorGridLines: MajorGridLines(width: 0),
    //     ),
    //     primaryYAxis: NumericAxis(
    //       axisLine: const AxisLine(color: Colors.transparent),
    //       minimum: 0,
    //       maximum: max,
    //       plotBands: <PlotBand>[
    //         const PlotBand(
    //             horizontalTextAlignment: TextAnchor.start,
    //             start: 0,
    //             end: 200,
    //             //max,
    //             opacity: 0.1,
    //             color: Colors.red,
    //             dashArray: <double>[4, 5]),
    //         PlotBand(
    //             horizontalTextAlignment: TextAnchor.start,
    //             start: 400,
    //             end: max,
    //             opacity: 0.1,
    //             color: Colors.red,
    //             dashArray: const <double>[4, 5]),
    //       ],
    //       isVisible: true,
    //       labelStyle: const TextStyle(fontSize: 8, color: Color(0xFF929395)),
    //     ),
    //     legend: const Legend(isVisible: false),
    //     tooltipBehavior: TooltipBehavior(enable: true),
    //     series: <CartesianSeries<GraphModel, String>>[
    //       SplineSeries<GraphModel, String>(
    //         enableTooltip: false,
    //         color: AppColors.blueColor,
    //         dataSource: listForGraph,
    //         width: 3,
    //         dataLabelSettings:
    //             const DataLabelSettings(showZeroValue: true, isVisible: true),
    //         markerSettings: const MarkerSettings(
    //             borderWidth: 5.0,
    //             color: Colors.white,
    //             isVisible: true,
    //             height: 5,
    //             width: 5,
    //             borderColor: AppColors.blueColor,
    //             shape: DataMarkerType.circle),
    //         xValueMapper: (GraphModel sales, _) {
    //           return sales.title;
    //         },
    //         yValueMapper: (GraphModel sales, _) => sales.value,
    //       ),
    //     ]);
  }
}
