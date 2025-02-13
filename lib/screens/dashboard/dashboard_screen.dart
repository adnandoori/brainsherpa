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
                      height: 66.h,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        'Hi ${controller.username},',
                        style: poppinsTextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            size: 22.sp),
                      ),
                    ),
                    10.sbh,
                    widgetStart(controller),
                    Expanded(
                        child: Container(
                            color: AppColors.bgColor,
                            child: widgetResult(controller))),
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
                              padding: EdgeInsets.only(
                                left: 10.w,
                                top: 16.h,
                              ),
                              width: Get.width,
                              color: AppColors.bgColor,
                              child: Text(
                                '${AppStrings.takenAt} ${controller.takenAt}',
                                maxLines: 1,
                                style: poppinsTextStyle(
                                    size: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )),
                          Container(
                            child: PerformanceScoreWidget(
                                labelText: 'Performance Score',
                                performanceScore:
                                    controller.performanceScore.toString(),
                                onTap: () {
                                  Get.toNamed(Routes.performanceScreen);
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.contbgcolor,
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
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reaction time',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
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
                                                  ))
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: AverageCard(
                                            label:
                                                '${AppStrings.average} 10% (ms)',
                                            value:
                                                controller.average.toString(),
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.reactionTimeListScreen,
                                                  arguments: [
                                                    controller.userId,
                                                    controller.reactionTestList
                                                  ]);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Expanded(
                                          child: AverageCard(
                                            label:
                                                '${AppStrings.fastest} 10% (ms)',
                                            value:
                                                controller.fastest.toString(),
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.reactionTimeListScreen,
                                                  arguments: [
                                                    controller.userId,
                                                    controller.reactionTestList
                                                  ]);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Expanded(
                                          child: AverageCard(
                                            label:
                                                '${AppStrings.slowest} 10% (ms)',
                                            value:
                                                controller.slowest.toString(),
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.reactionTimeListScreen,
                                                  arguments: [
                                                    controller.userId,
                                                    controller.reactionTestList
                                                  ]);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Cognitive Flexibility and Vigilance Index Section
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GuageScoreWidgetBox(
                                    labelText: 'Cognitive Flexibility',
                                    score: controller.cognitiveFlexibility
                                        .toString(),
                                    minValue: 0,
                                    maxValue: 100,
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.cognitiveFlexibilityScreen,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: GuageScoreWidgetBox(
                                    labelText: 'Vigilance Index',
                                    score: controller.vigilanceIndex.toString(),
                                    minValue: 0,
                                    maxValue: 100,
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.vigilanceIndexScreen,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    return SizedBox(
      height: 185.h,
      width: Get.width,
      child: Stack(
        children: [
          Image.asset(
            ImagePath.loginBackground,
            height: 190.h,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                  child: Center(
                    child: Text(
                      AppStrings.dashboardMessage,
                      style: poppinsTextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          size: 20.sp),
                    ),
                  )),
              SizedBox(height: 25.h),
              Center(
                child: InkWell(
                  onTap: () {
                    controller.navigateToStartTest();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 44.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.buttonColorGrey,
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.start,
                        style: poppinsTextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
