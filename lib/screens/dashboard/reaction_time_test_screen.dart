import 'package:brainsherpa/controllers/dashboard/reaction_time_test_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                    child: controller.isWaitForGreen
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

  Widget widgetResult() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Material(
            elevation: 3,
            borderRadius:  const BorderRadius.all(Radius.circular(12)),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.blueColor,
              ),
              height: Get.height,
              width: Get.width,
              child:
              Center(
                child: Text(
                  AppStrings.tapToStart,
                  style: poppinsTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      size: 22.sp),
                ),
              ),
            ),
          ))
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
          printf('---wait-for-green---->');
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
