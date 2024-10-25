import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

commonAppbarWithAppName({String? first, String? second}) {
  return Container(
    height: 66.h,
    color: Colors.white,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 25.w),
        child: RichText(
          text: TextSpan(
            text: first ?? 'BRAIN',
            style: poppinsTextStyle(
                size: 16.sp, color: Colors.black, fontWeight: FontWeight.w700),
            children: <TextSpan>[
              TextSpan(
                text: second ?? 'SHERPA',
                style: poppinsTextStyle(
                    size: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

buttonWithoutShadow(
    {required String title, TextStyle? sty, VoidCallback? onClick}) {
  return InkWell(
    onTap: onClick,
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: Text(
          title.toString(),
          style: sty ??
              poppinsTextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w400),
          //style: widget.labelStyle,
        ),
      ),
    ),
  );
}

buttonDefault({
  required String title,
  TextStyle? sty,
  VoidCallback? onClick,
}) {
  return InkWell(
    onTap: onClick,
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: Text(
          title.toString(),
          style: sty ??
              poppinsTextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w400),
          //style: widget.labelStyle,
        ),
      ),
    ),
  );
}

widgetAppBar({String? title}) {
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
                title.toString(),
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

widgetNoRecordFound() {
  return Center(
    child: Text(
      AppStrings.noRecordFound,
      style: poppinsTextStyle(color: Colors.black, size: 14.sp),
    ),
  );
}

printf(String msg) {
  if (kDebugMode) {
    print(msg);
  }
}

loaderShow() {
  Get.context!.loaderOverlay.show();
}

loaderHide() {
  Get.context!.loaderOverlay.hide();
}
