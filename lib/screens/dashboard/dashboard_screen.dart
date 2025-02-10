import 'package:brainsherpa/controllers/dashboard/dashboard_controller.dart';
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
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 25.w),
                      //   child: Text(
                      //     'Hi ${controller.username},',
                      //     style: poppinsTextStyle(
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColors.black,
                      //         size: 22.sp),
                      //   ),
                      // ),
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 10),
                          child: widgetResult(controller),
                        ),
                      ))
                    ],
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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.white,
      ),
      width: Get.width,
      child: Material(
        elevation: 1,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.reactionTimeListScreen,
                arguments: [controller.userId, controller.reactionTestList]);
          },
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white),
              width: Get.width,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  controller.fastest,
                                  style: poppinsTextStyle(
                                      color: Colors.black,
                                      size: 25.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                6.sbh,
                                Text(
                                  '${AppStrings.fastest}(in ms)',
                                  style: poppinsTextStyle(
                                      color: Colors.black,
                                      size: 13.sp,
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
                                  controller.slowest,
                                  style: poppinsTextStyle(
                                      color: Colors.black,
                                      size: 25.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                6.sbh,
                                Text(
                                  '${AppStrings.slowest}(in ms)',
                                  style: poppinsTextStyle(
                                      color: Colors.black,
                                      size: 13.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      elevation: 1,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 220.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade50, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.reactionTimeListScreen,
                                      arguments: [
                                        controller.userId,
                                        controller.reactionTestList
                                      ]);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.reactionTime,
                                      style: poppinsTextStyle(
                                          size: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
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
                                margin: EdgeInsets.only(
                                  left: 50.w,
                                  right: 50.w,
                                  top: 16.h,
                                ),
                                height: Get.height,
                                width: Get.width,
                                child: getRadialGauge(controller),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
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
              Text(
                'Hi ${controller.username},',
                style: poppinsTextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    size: 22.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                child: Text(
                  AppStrings.timeToTakeTheReaction,
                  style: poppinsTextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      size: 23.sp),
                ),
              ),
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
