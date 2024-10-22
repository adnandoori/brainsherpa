import 'package:brainsherpa/utils/app_colors.dart';
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
            text: first ?? 'PRO',
            style: poppinsTextStyle(
                size: 16.sp, color: Colors.black, fontWeight: FontWeight.w700),
            children: <TextSpan>[
              TextSpan(
                text: second ?? 'NEUROLIGHT',
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

buttonDefault(
    {required String title, TextStyle? sty, VoidCallback? onClick,}) {
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
