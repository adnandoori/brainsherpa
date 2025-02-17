import 'package:brainsherpa/controllers/dashboard/dashboard_controller.dart';
import 'package:brainsherpa/controllers/dashboard/reaction_time_test_controller.dart';
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
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _showModal(BuildContext context, String modalText) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Text(
              modalText, // Use the dynamic text here
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      id: DashboardController.stateId,
      builder: (controller) {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: SizedBox(
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: Stack(
                        children: [
                          commonAppbarWithAppName(
                              first: AppStrings.brain,
                              second: AppStrings.sherpa),
                          InkWell(
                            onTap: () {
                              controller.callLogout();
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: Image.asset(
                                  ImagePath.icLogout,
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widgetStart(controller),
                    Expanded(
                        child: Container(
                            color: AppColors.bgColor,
                            child: widgetResult(controller))),
                    // testValueContainer(
                    //   icon: Icons.info,
                    //   text: AppStrings.reactionTime,
                    //   value: controller.performanceScore.toString(),
                    //   modalText: 'adnan',
                    //   onIconTap: () => _showModal(context, "adnan"),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getRadialGauge(DashboardController controller) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          minimum: 0,
          maximum: 600,
          showAxisLine: false,
          showLabels: false,
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 200,
                color: Colors.red,
                startWidth: 30,
                endWidth: 30),
            GaugeRange(
                startValue: 200,
                endValue: 400,
                color: Colors.green,
                startWidth: 30,
                endWidth: 30),
            GaugeRange(
                startValue: 400,
                endValue: 600,
                color: Colors.red,
                startWidth: 30,
                endWidth: 30)
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              needleEndWidth: 5,
              needleStartWidth: 0,
              needleColor: Colors.black,
              value: double.parse(controller.average.toString()),
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    20.sbh,
                    Text(
                      controller.average,
                      style: poppinsTextStyle(
                          size: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'ms',
                      style: poppinsTextStyle(
                          size: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                angle: 90,
                positionFactor: 0.5)
          ])
    ]);
  }

  Widget widgetResult(DashboardController controller) {
    final reactionTimeController = Get.put(ReactionTimeTestController());

    // List<GraphModel> listForGraph = [];
    // if (data.reactionTest!.isNotEmpty) {
    //   for (int i = 0; i < data.reactionTest!.length; i++) {
    //     int diff = int.parse(
    //             data.reactionTest![i].tapTimeForGreenCard.toString()) -
    //         int.parse(data.reactionTest![i].startTimeForGreenCard.toString());

    //     int? randomTime = data.reactionTest![i].randomTime;

    //     listForGraph.add(GraphModel(randomTime.toString(), diff));

    //     //printf('----difference-for-time-test---->$diff---random-time-->$randomTime');
    //   }
    // }

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.bgColor,
      ),
      width: Get.width,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            width: Get.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: AppColors.bgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                PerformanceGuagePointer(
                                    labelText: 'Performance Score',
                                    score: controller.performanceScore,
                                    measurementValue: double.tryParse(
                                            controller.performanceScore) ??
                                        0.0,
                                    labelunit: '(in %)',
                                    minValue: 0,
                                    maxValue: 100,
                                    onTap: () {}),
                                CognitiveSpeedGuage(
                                    labelText: 'Cognitive Speed',
                                    score: controller.cognitiveSpeed.toString(),
                                    labelunit: '(in Reactions/s)',
                                    minValue: 0,
                                    maxValue: 6.6,
                                    onTap: () {}),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
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
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.reactionTimeListScreen,
                                    arguments: [
                                      controller.userId,
                                      controller.reactionTestList
                                    ]);
                              },
                              child: Container(
                                width: Get.width,
                                height: 300.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(5.h),
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
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  '${AppStrings.takenAt} ${controller.takenAt}',
                                                  maxLines: 1,
                                                  style: poppinsTextStyle(
                                                      size: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            ImagePath.icNext,
                                            height: 16,
                                            width: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(top: 0.h),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          height: Get.height,
                                          width: Get.width,
                                          child: Stack(
                                            children: [
                                              SfCartesianChart(
                                                  primaryXAxis:
                                                      const CategoryAxis(
                                                    majorGridLines:
                                                        MajorGridLines(
                                                            width: 0),
                                                    title: AxisTitle(
                                                        text:
                                                            'Elapsed Time (secs)'),
                                                    isVisible: false,
                                                  ),
                                                  primaryYAxis:
                                                      const NumericAxis(
                                                    axisLine: AxisLine(
                                                        color: Colors.black),
                                                    minimum: 400,
                                                    //controller.maximumValue,
                                                    maximum: 0,
                                                    isInversed: true,
                                                    plotBands: <PlotBand>[
                                                      PlotBand(
                                                          horizontalTextAlignment:
                                                              TextAnchor.start,
                                                          start: 0,
                                                          end: 100,
                                                          opacity: 0.1,
                                                          color: Colors.yellow,
                                                          dashArray: <double>[
                                                            4,
                                                            5
                                                          ]),
                                                      PlotBand(
                                                          horizontalTextAlignment:
                                                              TextAnchor.start,
                                                          start: 350,
                                                          end: 400,
                                                          // controller.maximumValue,
                                                          opacity: 0.1,
                                                          color: Colors.red,
                                                          dashArray: <double>[
                                                            4,
                                                            5
                                                          ]),
                                                    ],
                                                    isVisible: true,
                                                    labelStyle: TextStyle(
                                                        fontSize: 8,
                                                        color:
                                                            Color(0xFF929395)),
                                                  ),
                                                  legend: const Legend(
                                                      isVisible: false),
                                                  tooltipBehavior:
                                                      TooltipBehavior(
                                                          enable: true),
                                                  series: <CartesianSeries>[
                                                    SplineSeries<GraphModel,
                                                            String>(
                                                        color: AppColors
                                                            .blueColor,
                                                        markerSettings:
                                                            const MarkerSettings(
                                                          isVisible: true,
                                                          color: AppColors
                                                              .blueColor,
                                                          borderColor: AppColors
                                                              .blueColor,
                                                          shape: DataMarkerType
                                                              .circle,
                                                          width: 5,
                                                          height: 5,
                                                        ),
                                                        dataLabelSettings:
                                                            const DataLabelSettings(
                                                                textStyle: TextStyle(
                                                                    fontSize: 9,
                                                                    color: Color(
                                                                        0xFF0080FF)),
                                                                showZeroValue:
                                                                    false,
                                                                isVisible:
                                                                    false),
                                                        dataSource:
                                                            reactionTimeController
                                                                .listForGraph,
                                                        trendlines: <Trendline>[
                                                          Trendline(
                                                              type:
                                                                  TrendlineType
                                                                      .linear,
                                                              color:
                                                                  Colors.black)
                                                        ],
                                                        xValueMapper:
                                                            (GraphModel data,
                                                                    _) =>
                                                                data.title,
                                                        yValueMapper:
                                                            (GraphModel data,
                                                                    _) =>
                                                                data.value),
                                                  ]),
                                              Row(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.h,
                                                          bottom: 5.h),
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
                                                                  '400')),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
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
                                                                child:
                                                                    Container()),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              width: 1,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        )),
                                                        Expanded(
                                                            child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              width: 1,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        )),
                                                        Expanded(
                                                            child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              width: 1,
                                                              color:
                                                                  Colors.black,
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
                                    SizedBox(height: 5.h),
                                    Container(
                                      margin: EdgeInsets.only(),
                                      child: Text(controller.trendInsight),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.reactionStatistics,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: AverageCard(
                                      label: '${AppStrings.average} 10% (ms)',
                                      value: controller.average.toString(),
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.reactionStatistics,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 50.h,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: AverageCard(
                                      label: '${AppStrings.fastest} 10% (ms)',
                                      value: controller.fastest.toString(),
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.reactionStatistics,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 50.h,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: AverageCard(
                                      label: '${AppStrings.slowest} 10% (ms)',
                                      value: controller.slowest.toString(),
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.reactionStatistics,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      ImagePath.icNext,
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(1),
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
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.falseLapsesScreen,
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AverageCard(
                                    label: 'False Starts',
                                    value: controller.falseStart.toString(),
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.falseLapsesScreen,
                                      );
                                    },
                                  ),
                                  Container(
                                    width: 1,
                                    height: 50.h,
                                    color: Colors.grey,
                                  ),
                                  AverageCard(
                                    label: 'Lapses',
                                    value: controller.lapses.toString(),
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.falseLapsesScreen,
                                      );
                                    },
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      ImagePath.icNext,
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          LineraGuagePointer(
                              heading: 'Resilience',
                              currentValue: double.tryParse(
                                      controller.resilienceScore.toString()) ??
                                  0.0,
                              minValue: 0,
                              maxValue: 100,
                              text1: 'Easily Distracted',
                              text2: 'Mentally Tough',
                              onTap: () {}),
                          LineraGuagePointer(
                              heading: 'Focus Score',
                              currentValue: double.tryParse(
                                      controller.focusScore.toString()) ??
                                  0.0,
                              minValue: 0,
                              maxValue: 100,
                              text1: 'Inconsistent',
                              text2: 'Deep Focus',
                              onTap: () {}),
                          LineraGuagePointer(
                              heading: 'Cognitive Flexibility',
                              currentValue: double.tryParse(
                                      controller.flexibilityScore.toString()) ??
                                  0.0,
                              minValue: 0,
                              maxValue: 100,
                              text1: 'Rigid Thinking',
                              text2: 'Highly Adaptable',
                              onTap: () {}),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetStart(DashboardController controller) {
    return Container(
      height: 50.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(color: Color.fromARGB(255, 62, 50, 97)),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10.w, right: 0.w, top: 0.h),
                child: Center(
                  child: Text(
                    AppStrings.dashboardMessage,
                    style: poppinsTextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        size: 18.sp),
                  ),
                )),
            SizedBox(height: 25.h),
            Center(
              child: InkWell(
                onTap: () {
                  controller.navigateToStartTest();
                },
                child: Container(
                  margin: EdgeInsets.all(10.h),
                  // height: 30.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.indicatorGray,
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.start,
                      style: poppinsTextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          size: 12.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget widgetText(text) {
  return Text(
    textAlign: TextAlign.center,
    text,
    style: const TextStyle(fontSize: 10, color: Colors.transparent),
  );
}

Widget PerformanceWidgetBox(DashboardController controller) {
  final reactionTimeController = Get.put(ReactionTimeTestController());

  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(
              Routes.performanceScreen,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Performance Score",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${controller.performanceScore.toString()}",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/100",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Performance Variability: 50%",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              SizedBox(
                  width: 100,
                  height: 100,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 150, // Adjusted for a semi-circle layout
                        endAngle: 30,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 15, // Increased thickness for bold design
                          color: Colors
                              .transparent, // Hide the full axis background
                        ),
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: 50,
                            enableAnimation: true,
                            needleStartWidth: 1,
                            needleEndWidth: 5,
                            needleLength: 0.55,
                            needleColor: Colors.black,
                            knobStyle: KnobStyle(
                                color: Colors.black,
                                sizeUnit: GaugeSizeUnit.logicalPixel),
                          ),
                        ],
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: 0,
                            endValue: 20, // First segment in light purple
                            color: Colors.red,
                            startWidth: 0,
                            endWidth: 15,
                          ),
                          GaugeRange(
                            startValue: 20,
                            endValue: 22, // Second segment in medium purple
                            color: Colors.white,
                            startWidth: 15,
                            endWidth: 15,
                          ),
                          GaugeRange(
                            startValue: 22,
                            endValue: 40, // Second segment in medium purple
                            color: Colors.orange,
                            startWidth: 15,
                            endWidth: 15,
                          ),
                          GaugeRange(
                            startValue: 40,
                            endValue: 42, // Second segment in medium purple
                            color: Colors.white,
                            startWidth: 15,
                            endWidth: 15,
                          ),
                          GaugeRange(
                            startValue: 42,
                            endValue: 80, // Second segment in medium purple
                            color: Color.fromARGB(255, 226, 204, 0),
                            startWidth: 15,
                            endWidth: 15,
                          ),
                          GaugeRange(
                            startValue: 80,
                            endValue: 82, // Second segment in medium purple
                            color: Colors.white,
                            startWidth: 15,
                            endWidth: 15,
                          ),
                          GaugeRange(
                            startValue: 82,
                            endValue: 100, // Third segment in deep purple
                            color: Colors.green,
                            startWidth: 15,
                            endWidth: 15,
                          ),
                        ],
                      ),
                    ],
                  )),
              Image.asset(
                ImagePath.icNext,
                height: 16,
                width: 16,
              ),
            ],
          ),
        ),
        _buildProgressBar("Cognitive Speed", 40),
        SizedBox(height: 8),
        _buildProgressBar("Cognitive Flexibility",
            double.parse(controller.cognitiveFlexibility.toString())),
        SizedBox(height: 8),
        _buildProgressBar("Focus", 90),
        SizedBox(height: 8),
        _buildProgressBar(
            "Resiliency", double.parse(controller.resilience.toString())),
      ],
    ),
  );
}

Widget _buildProgressBar(String label, double value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(fontSize: 14)),
          SizedBox(width: 4),
          Container(
            width: 150,
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey.shade300,
              color: value <= 20
                  ? Colors.red // Red if value is 33 or less
                  : value <= 40 && value > 20
                      ? Colors.orange
                      : value <= 60 && value > 40
                          ? const Color.fromARGB(255, 226, 204,
                              0) // Yellow if value is between 33 and 66
                          : value <= 80 && value > 60
                              ? Color.fromARGB(255, 176, 240,
                                  1) // Orange if value is between 34 and 66
                              : Colors.green,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ]),
      ),
    ],
  );
}




// Expanded(
//     child: Column(
//   children: [
//     Text(
//       controller.fastest,
//       style: poppinsTextStyle(
//           color: Colors.black,
//           size: 25.sp,
//           fontWeight: FontWeight.w500),
//     ),
//     6.sbh,
//     Text(
//       '${AppStrings.fastest}(in ms)',
//       style: poppinsTextStyle(
//           color: Colors.black,
//           size: 13.sp,
//           fontWeight: FontWeight.w500),
//     )
//   ],
// )),
// Container(
//   width: 1,
//   height: 64.h,
//   color: Colors.grey,
// ),
// Expanded(
//     child: Column(
//   children: [
//     Text(
//       controller.slowest,
//       style: poppinsTextStyle(
//           color: Colors.black,
//           size: 25.sp,
//           fontWeight: FontWeight.w500),
//     ),
//     6.sbh,
//     Text(
//       '${AppStrings.slowest}(in ms)',
//       style: poppinsTextStyle(
//           color: Colors.black,
//           size: 13.sp,
//           fontWeight: FontWeight.w500),
//     )
//   ],
// )),
