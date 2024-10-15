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
                body: Container(
                  height: Get.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonAppbarWithAppName(
                          first: AppStrings.brain, second: AppStrings.sherpa),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Text(
                          'Hi John,',
                          style: poppinsTextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                              size: 22.sp),
                        ),
                      ),
                      10.sbh,
                      SizedBox(
                        height: 180.h,
                        width: Get.width,
                        child: Stack(
                          children: [
                            Image.asset(
                              ImagePath.loginBackground,
                              height: 180.h,
                              width: Get.width,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 40.w, right: 40.w, top: 25.h),
                              child: Text(
                                AppStrings.timeToTakeTheReaction,
                                style: poppinsTextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                    size: 23.sp),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
