import 'package:brainsherpa/controllers/dashboard/dashboard_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/extension_classes.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                                    height: 24,
                                    width: 24,
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
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget widgetStart(DashboardController controller) {
    return SizedBox(
      height: 190.h,
      width: Get.width,
      child: Stack(
        children: [
          Image.asset(
            ImagePath.loginBackground,
            height: 190.h,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 25.h),
            child: Text(
              AppStrings.timeToTakeTheReaction,
              style: poppinsTextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  size: 23.sp),
            ),
          ),
          InkWell(
            onTap: () {
              controller.navigateToReactionTest();
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 30.h),
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
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
