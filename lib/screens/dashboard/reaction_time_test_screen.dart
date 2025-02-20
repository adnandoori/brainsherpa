import 'package:brainsherpa/controllers/dashboard/reaction_time_test_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/extension_classes.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class ReactionTimeTestScreen extends StatelessWidget {
  const ReactionTimeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.bgColor,
        body: GetBuilder<ReactionTimeTestController>(
          init: ReactionTimeTestController(),
          autoRemove: true,
          id: ReactionTimeTestController.stateId,
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widgetAppBar(title: AppStrings.reactionTimeTest),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: controller.isResult
                        ? widgetResult(controller)
                        : controller.isWaitForGreen
                            ? widgetWaitForGreen(controller)
                            : controller.isGreen
                                ? widgetGreen(controller)
                                : widgetStartTest(controller),
                  )),
                  15.sbh,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetResult(ReactionTimeTestController controller) {
    return SizedBox(
      //height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Material(
            elevation: 0,
            child: SingleChildScrollView(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    // color: AppColors.blueColor,
                  ),
                  width: Get.width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TestScreenPerformanceGuagePointer(
                                  labelText: 'Performance Score',
                                  score: controller.performanceScore,
                                  measurementValue: double.tryParse(
                                          controller.performanceScore) ??
                                      0.0,
                                  labelunit: '(in %)',
                                  minValue: 0,
                                  maxValue: 100,
                                ),
                                TestScreenCognitiveSpeedGuage(
                                  labelText: 'Cognitive Speed',
                                  score: controller.speed.toString(),
                                  labelunit: '(in Reactions/s)',
                                  minValue: 0,
                                  maxValue: 6.6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.01,
                              vertical: Get.height * 0.01,
                            ), // Margin is responsive
                            padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.01,
                              horizontal:
                                  Get.width * 0.01, // Padding is responsive
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.backgroundColor,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            width: Get.width,
                            height: 250.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Reaction Time Curve',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                // fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${AppStrings.takenAt}  ${controller.startTestTime}',
                                              maxLines: 1,
                                              style: poppinsTextStyle(
                                                  size: Get.width * 0.022,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 0.h),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      height: Get.height,
                                      width: Get.width,
                                      child: Stack(
                                        children: [
                                          SfCartesianChart(
                                            primaryXAxis: const CategoryAxis(
                                              majorGridLines:
                                                  MajorGridLines(width: 0),
                                              title: AxisTitle(
                                                  text: 'Elapsed Time (secs)'),
                                              isVisible: false,
                                            ),
                                            primaryYAxis: NumericAxis(
                                              axisLine:
                                                  AxisLine(color: Colors.black),
                                              minimum: 0,
                                              maximum: controller
                                                  .maximumValue, // Set max value as controller.maximumValue
                                              isInversed: true,
                                              plotBands: <PlotBand>[
                                                PlotBand(
                                                  horizontalTextAlignment:
                                                      TextAnchor.start,
                                                  start: 0,
                                                  end: 100,
                                                  opacity: 0.1,
                                                  color: Colors.yellow,
                                                  dashArray: <double>[4, 5],
                                                ),
                                                PlotBand(
                                                  horizontalTextAlignment:
                                                      TextAnchor.start,
                                                  start: 350,
                                                  end: controller.maximumValue,
                                                  opacity: 0.1,
                                                  color: Colors.red,
                                                  dashArray: <double>[4, 5],
                                                ),
                                              ],
                                              isVisible: true,
                                              labelStyle: TextStyle(
                                                  fontSize: 8,
                                                  color: Color(0xFF929395)),
                                            ),
                                            legend:
                                                const Legend(isVisible: false),
                                            tooltipBehavior:
                                                TooltipBehavior(enable: true),
                                            series: <CartesianSeries>[
                                              SplineSeries<GraphModel, String>(
                                                color: AppColors.blueColor,
                                                markerSettings:
                                                    const MarkerSettings(
                                                  isVisible: true,
                                                  color: AppColors.blueColor,
                                                  borderColor:
                                                      AppColors.blueColor,
                                                  shape: DataMarkerType.circle,
                                                  width: 5,
                                                  height: 5,
                                                ),
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                  textStyle: TextStyle(
                                                      fontSize: 9,
                                                      color: Color(0xFF0080FF)),
                                                  showZeroValue: false,
                                                  isVisible: false,
                                                ),
                                                dataSource:
                                                    controller.listForGraph,
                                                trendlines: <Trendline>[
                                                  Trendline(
                                                      type:
                                                          TrendlineType.linear,
                                                      color: Colors.black)
                                                ],
                                                xValueMapper:
                                                    (GraphModel data, _) =>
                                                        data.title,
                                                yValueMapper:
                                                    (GraphModel data, _) =>
                                                        data.value,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 5.h, bottom: 5.h),
                                                  width: 34.w,
                                                  //color: Colors.red,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          child: widgetText(
                                                              '100')),
                                                      Expanded(
                                                          child: widgetText(
                                                              '150')),
                                                      Expanded(
                                                          child: widgetText(
                                                              '200')),
                                                      Expanded(
                                                          child: widgetText(
                                                              '250')),
                                                      Expanded(
                                                          child: widgetText(
                                                              '300')),
                                                      Expanded(
                                                          child: widgetText(
                                                              '350')),
                                                      Expanded(
                                                        child: widgetText(
                                                          controller
                                                              .maximumValue
                                                              .toString(), // Convert double to String
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.h,
                                                    horizontal: 10.w),
                                                //color: Colors.green.shade100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    )),
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    )),
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container()),
                                                        Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          width: 1,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    )),
                                                  ],
                                                ),
                                              )),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.01,
                              vertical: Get.height * 0.01,
                            ), // Margin is responsive
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  Get.width * 0.01, // Padding is responsive
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.backgroundColor,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                AverageCard(
                                    label: '${AppStrings.average} 10% (ms)',
                                    value: controller.average.toString(),
                                    onTap: () {}),
                                Container(
                                  width: 1,
                                  height: 50.h,
                                  color: Colors.grey,
                                ),
                                AverageCard(
                                    label: '${AppStrings.fastest} 10% (ms)',
                                    value: controller.fastest.toString(),
                                    onTap: () {}),
                                Container(
                                  width: 1,
                                  height: 50.h,
                                  color: Colors.grey,
                                ),
                                AverageCard(
                                    label: '${AppStrings.slowest} 10% (ms)',
                                    value: controller.slowest.toString(),
                                    onTap: () {}),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.01,
                            ), // Margin is responsive
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  Get.width * 0.02, // Padding is responsive
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.backgroundColor,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                AverageCard(
                                  label: 'False Starts',
                                  value: controller.falseStart.toString(),
                                  onTap: () {},
                                ),
                                Container(
                                  width: 1,
                                  height: 50.h,
                                  color: Colors.grey,
                                ),
                                AverageCard(
                                  label: 'Lapses',
                                  value: controller.plusLapses.toString(),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            // child: Container(
                            //   //height: 200.h,
                            //   width: Get.width,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color: AppColors.blueColor, width: 1),
                            //     borderRadius:
                            //         const BorderRadius.all(Radius.circular(12)),
                            //     color: AppColors.whiteShadow,
                            //   ),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       10.sbh,
                            //       Text(
                            //         '${AppStrings.speed}:   ${controller.speed} reactions/s',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         '${AppStrings.falseStart}:  ${controller.falseStart} reactions',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       // Text(
                            //       //   '${AppStrings.performanceScore}:  ${controller.performanceScore} %',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       // Text(
                            //       //   '${AppStrings.accuracy}:  ${controller.accuracy}%',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       // Text(
                            //       //   '${AppStrings.successRate}:  ${controller.successRate}%',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       Text(
                            //         '${AppStrings.delta} s-f:  ${controller.delta} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         '${AppStrings.lapseProbability}:  ${controller.lapseProbability}',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Mini Lapse:  ${controller.listForPlusLapses355.length} Reactions',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Total Lapse:  ${controller.listForPlusLapses500.length} Reactions',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'S Lapse:  ${controller.listForPlusLapses700.length} Reactions',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         '${AppStrings.variation}:   ${controller.variation} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         '${AppStrings.plusLapses}:    ${controller.plusLapses} reactions',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Isi 0 to 2:    ${controller.avgForIsi0to2} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Isi 2 to 4:    ${controller.avgForIsi2to4} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Delta Isi:    ${controller.deltaIsi} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'False Start Isi 0 to 2:    ${controller.countForFalseStartIsi0to2}',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'False Start Isi 2 to 4:    ${controller.countForFalseStartIsi2to4}',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Plus Lapse Isi 0 to 2:    ${controller.countForPlusLapsesIsi0to2}',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Plus Lapse Isi 2 to 4:    ${controller.countForPlusLapsesIsi2to4}',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       // Text(
                            //       //   'Slowing rate :    ${controller.slowingRate} %',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       // Text(
                            //       //   'Performance decline :    ${controller.performanceDecline} %',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       // Text(
                            //       //   'lapses/M :    ${controller.LPM} L/m',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       // Text(
                            //       //   'False starts/M :    ${controller.FPM} F/m',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       // Text(
                            //       //   'IQR :    ${controller.IQR} ms',
                            //       //   style: poppinsTextStyle(
                            //       //       color: Colors.black,
                            //       //       fontWeight: FontWeight.w400),
                            //       // ),
                            //       // 2.sbh,
                            //       Text(
                            //         'PSR :    ${controller.PSR} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Recovery time :    ${controller.RTRT} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Vigilance Index :    ${controller.vigilanceIndex} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Alertness :    ${controller.alertness} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Resilience :    ${controller.resilienceScore} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Focusscore :    ${controller.focusScore} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Flexibility :   ${controller.flexibilityScore} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Fatigue :    ${controller.fatigue} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Attention :  ${controller.attention} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Cognitive Flexibility : ${controller.cognitiveFlexibility} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Response Control :    ${controller.responseControl} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Cognitive Load :    ${controller.cognitiveLoad} %',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Avg for first min :    ${controller.avgForFirstMin} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Avg for second min :    ${controller.avgForSecondMin} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       2.sbh,
                            //       Text(
                            //         'Avg for third min :    ${controller.avgForThirdMin} ms',
                            //         style: poppinsTextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //       ),
                            //       10.sbh,
                            //     ],
                            //   ),
                            // ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          )),
          Container(
            margin: EdgeInsets.only(bottom: 10.h, top: 30.h),
            height: 52.h,
            child: buttonDefault(
                title: AppStrings.save,
                onClick: () {
                  controller.buttonSave();
                }),
          )
        ],
      ),
    );
  }

  Widget widgetResult1(ReactionTimeTestController controller) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Material(
            elevation: 0,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: AppColors.blueColor,
                ),
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300.h,
                          child: Container(
                            width: Get.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              color: AppColors.blueColor,
                            ),
                            child: Column(
                              children: [
                                25.sbh,
                                Text(
                                  '${AppStrings.average}(ms):',
                                  style: poppinsTextStyle(
                                      size: 22.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                10.sbh,
                                Text(
                                  controller.average.toString(),
                                  style: poppinsTextStyle(
                                      size: 52.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                30.sbh,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '${AppStrings.fastest}(ms):',
                                      style: poppinsTextStyle(
                                          size: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '${AppStrings.slowest}(ms):',
                                      style: poppinsTextStyle(
                                          size: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      controller.fastest.toString(),
                                      style: poppinsTextStyle(
                                          size: 38.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      controller.slowest.toString(),
                                      style: poppinsTextStyle(
                                          size: 38.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 220.h,
                          color: Colors.white,
                          width: Get.width,
                          child: SfCartesianChart(
                              primaryXAxis: const CategoryAxis(
                                majorGridLines: MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                axisLine:
                                    const AxisLine(color: Colors.transparent),
                                minimum: 0,
                                maximum: controller.maximumValue,
                                plotBands: const <PlotBand>[
                                  PlotBand(
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
                                      end: 600,
                                      //controller.maximumValue,
                                      opacity: 0.1,
                                      color: Colors.red,
                                      dashArray: <double>[4, 5]),
                                ],
                                isVisible: true,
                                labelStyle: const TextStyle(
                                    fontSize: 8, color: Color(0xFF929395)),
                              ),
                              legend: const Legend(isVisible: false),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <SplineSeries<GraphModel, String>>[
                                SplineSeries<GraphModel, String>(
                                    enableTooltip: false,
                                    color: AppColors.buttonColor,
                                    dataSource: controller.listForGraph,
                                    xValueMapper: (GraphModel sales, _) =>
                                        sales.title,
                                    yValueMapper: (GraphModel sales, _) {
                                      return sales.value;
                                    },
                                    // Enable data label
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true))
                              ]),
                        )
                      ],
                    ),
                  ],
                )),
          )),
          Container(
            margin: EdgeInsets.only(bottom: 10.h, top: 30.h),
            height: 52.h,
            child: buttonDefault(
                title: AppStrings.save,
                onClick: () {
                  controller.buttonSave();
                }),
          )
        ],
      ),
    );
  }

  Widget widgetStartTest(ReactionTimeTestController controller) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: GestureDetector(
        onTap: () {
          printf('---tap-t-start---->');
          controller.startTest();
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.blueColor,
          ),
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.h),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  AppStrings.tapToStart,
                  style: poppinsTextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 40.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetWaitForGreen(ReactionTimeTestController controller) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: GestureDetector(
        onTapDown: (_) {
          controller.clickOnRedTap();
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.redColor,
          ),
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: AnimatedOpacity(
              //     duration: const Duration(milliseconds: 200),
              //     opacity: controller.opacity,
              //     child: Padding(
              //         padding: EdgeInsets.only(top: 80.h),
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               controller.animationText,
              //               style: poppinsTextStyle(
              //                   size: 52.sp,
              //                   color: Colors.black,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //             5.sbw,
              //             Padding(
              //               padding: EdgeInsets.only(bottom: 8.h),
              //               child: Text(
              //                 controller.animationText.isNotEmpty ? 'ms' : '',
              //                 style: poppinsTextStyle(
              //                     size: 22.sp,
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w400),
              //               ),
              //             ),
              //           ],
              //         )),
              //   ),
              // ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      AppStrings.waitForGreen,
                      style: poppinsTextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          size: 40.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetGreen(ReactionTimeTestController controller) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: GestureDetector(
        onTapDown: (_) {
          controller.clickOnGreen();
        },
        // onTap: ()
        // {
        //
        // },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.greenColor,
          ),
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.h),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  AppStrings.tap,
                  style: poppinsTextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 40.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetText(text) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: const TextStyle(fontSize: 10, color: Colors.transparent),
    );
  }
}
