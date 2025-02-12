import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

PerformanceScoreWidget({
  required String labelText,
  required String performanceScore,
}) {
  return Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          child: Row(
            children: [
              Text(
                performanceScore,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
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
      ],
    ),
  );
}

GuageScoreWidgetBox({
  required String labelText,
  required String score,
  required double minValue,
  required double maxValue,
}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(2.h),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Container(
            height: 100,
            child: SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: minValue,
                  maximum: maxValue,
                  showAxisLine: true,
                  showLabels: false,
                  ranges: [
                    GaugeRange(startValue: 0, endValue: 40, color: Colors.red),
                    GaugeRange(
                        startValue: 40, endValue: 60, color: Colors.yellow),
                    GaugeRange(
                        startValue: 60, endValue: 100, color: Colors.green),
                  ],
                  pointers: [
                    NeedlePointer(
                      value: double.parse(score),
                      needleLength: 0.6,
                      needleStartWidth: 1,
                      needleEndWidth: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

AverageCard({
  required String label,
  required String value,
}) {
  {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
