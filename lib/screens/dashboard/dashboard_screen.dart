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
                body: SingleChildScrollView(
                  child: SizedBox(
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
                        Container(
                            padding: EdgeInsets.only(
                              left: 25.w,
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
                        Expanded(
                            child: Container(
                                color: AppColors.bgColor,
                                child: widgetResult(controller))),
                      ],
                    ),
                  ),
                )),
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
    Get.put(ReactionTimeTestController());
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.bgColor,
      ),
      width: Get.width,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.reactionTimeListScreen,
                arguments: [controller.userId, controller.reactionTestList]);
          },
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
                            child: PerformanceScoreWidget(
                                labelText: 'Performance Score',
                                performanceScore:
                                    controller.performanceScore.toString()),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: AverageCard(
                                      label: '${AppStrings.average} 10% (ms)',
                                      value: controller.average.toString()),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: AverageCard(
                                      label: '${AppStrings.fastest} 10% (ms)',
                                      value: controller.fastest.toString()),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: AverageCard(
                                      label: '${AppStrings.slowest} 10% (ms)',
                                      value: controller.slowest.toString()),
                                ),
                              ],
                            ),
                          ),
                          // Cognitive Flexibility and Vigilance Index Section
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GuageScoreWidgetBox(
                                      labelText: 'Cognitive Flexibility',
                                      score: controller.cognitiveFlexibility
                                          .toString(),
                                      minValue: 0,
                                      maxValue: 100),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: GuageScoreWidgetBox(
                                      labelText: 'Vigilance Index',
                                      score:
                                          controller.vigilanceIndex.toString(),
                                      minValue: 0,
                                      maxValue: 100),
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
