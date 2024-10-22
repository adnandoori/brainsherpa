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
import 'package:syncfusion_flutter_charts/charts.dart';

class ReactionTimeTestScreen extends StatelessWidget {
  const ReactionTimeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: GetBuilder<ReactionTimeTestController>(
          init: ReactionTimeTestController(),
          id: ReactionTimeTestController.stateId,
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widgetAppBar(),
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: controller.isResult
                        ? widgetResult(controller)
                        : controller.isWaitForGreen
                            ? widgetWaitForGreen(controller)
                            : controller.isGreen
                                ? widgetGreen(controller)
                                : widgetStartTest(controller),
                  ))
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
            borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                            margin: EdgeInsets.only(top: 10.h),
                            height: 220.h,
                            color: Colors.white,
                            width: Get.width,
                            child: SfCartesianChart(
                                primaryXAxis: const CategoryAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                ),
                                primaryYAxis: CategoryAxis(
                                  minimum: 0,
                                  maximum: controller.maximumValue,
                                ),
                                legend: const Legend(isVisible: false),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries>[
                                  LineSeries<GraphModel, String>(
                                      color: AppColors.blueColor,
                                      markerSettings: const MarkerSettings(
                                        isVisible: true,
                                        color: AppColors.blueColor,
                                        borderColor: AppColors.blueColor,
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
                                              isVisible: false),
                                      dataSource: controller.listForGraph,
                                      xValueMapper: (GraphModel data, _) =>
                                          data.title,
                                      yValueMapper: (GraphModel data, _) =>
                                          data.value),
                                ]),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 200.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.blueColor, width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color: AppColors.whiteShadow,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${AppStrings.speed}:   ${controller.speed} reactions/s',
                                    style: poppinsTextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  2.sbh,
                                  Text(
                                    '${AppStrings.falseStart}:  ${controller.falseStart} reactions',
                                    style: poppinsTextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  2.sbh,
                                  Text(
                                    '${AppStrings.performanceScore}:  ${controller.accuracy}%',
                                    style: poppinsTextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  2.sbh,
                                  Text(
                                    '${AppStrings.variation}:   ${controller.variation} ms',
                                    style: poppinsTextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  2.sbh,
                                  Text(
                                    '${AppStrings.plusLapses}:    ${controller.plusLapses} reactions',
                                    style: poppinsTextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
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
                              legend: const Legend(isVisible: false),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ColumnSeries<GraphModel, String>>[
                                ColumnSeries<GraphModel, String>(
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
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     height: 200.h,
                    //     width: Get.width,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: AppColors.blueColor, width: 1),
                    //       borderRadius: const BorderRadius.all(Radius.circular(12)),
                    //       color: AppColors.whiteShadow,
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           '${AppStrings.speed}:   ${controller.speed} reactions/s',
                    //           style: poppinsTextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w400),
                    //         ),
                    //         2.sbh,
                    //         Text(
                    //           '${AppStrings.falseStart}:  ${controller.falseStart} reactions',
                    //           style: poppinsTextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w400),
                    //         ),
                    //         2.sbh,
                    //         Text(
                    //           '${AppStrings.performanceScore}:  ${controller.accuracy}%',
                    //           style: poppinsTextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w400),
                    //         ),
                    //         2.sbh,
                    //         Text(
                    //           '${AppStrings.variation}:   ${controller.variation} ms',
                    //           style: poppinsTextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w400),
                    //         ),
                    //         2.sbh,
                    //         Text(
                    //           '${AppStrings.plusLapses}:    ${controller.plusLapses} reactions',
                    //           style: poppinsTextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w400),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // )
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
      child: InkWell(
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
            child: Text(
              AppStrings.tapToStart,
              style: poppinsTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  size: 22.sp),
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
      child: InkWell(
        onTap: () {
          controller.clickOnRedTap();
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.redColor,
          ),
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Text(
              AppStrings.waitForGreen,
              style: poppinsTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  size: 22.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetGreen(ReactionTimeTestController controller) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: () {
          controller.clickOnGreen();
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: AppColors.greenColor,
          ),
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Text(
              AppStrings.tap,
              style: poppinsTextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  size: 22.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetAppBar() {
    return SizedBox(
      height: 66.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 18.w),
                      child: Image.asset(
                        ImagePath.icBack,
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ),
                ),
                Text(
                  AppStrings.reactionTimeTest,
                  style: poppinsTextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 22.sp),
                )
              ],
            )),
      ),
    );
  }
}
