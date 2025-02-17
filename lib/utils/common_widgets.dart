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
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(10),
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
    ),
  );
}

CognitiveSpeedGuage({
  required String labelText,
  required String score,
  required String labelunit,
  required double minValue,
  required double maxValue,
  required VoidCallback onTap,
}) {
  // Make score 2 decimal places
  String formattedScore = double.parse(score).toStringAsFixed(2);

  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(Get.width * 0.02), // Margin is responsive
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02,
          horizontal: Get.width * 0.03, // Padding is responsive
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Label Text
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelText,
                    style: TextStyle(
                      fontSize: Get.width * 0.03, // Font size based on width
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    ImagePath.icNext,
                    height: Get.width * 0.03, // Image size based on width
                    width: Get.width * 0.03,
                  ),
                ],
              ),
            ),
            Text(
              labelunit,
              style: TextStyle(
                fontSize: Get.width * 0.022, // Font size based on width
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Container(
              width: Get.width,
              height: Get.height * 0.15, // Height based on screen height
              child: SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: minValue,
                    maximum: maxValue,
                    showAxisLine: false,
                    showLabels: false,
                    ranges: [
                      GaugeRange(
                        startValue: 0,
                        endValue: 2,
                        color: Color(0xFFA5ABE2),
                        startWidth: 0,
                        endWidth: 15,
                      ),
                      GaugeRange(
                        startValue: 2,
                        endValue: 2.2,
                        color: Colors.white,
                        startWidth: 15,
                        endWidth: 15,
                      ),
                      GaugeRange(
                        startValue: 2.2,
                        endValue: 3.5,
                        color: Color(0xFFA9AAE4),
                        startWidth: 15,
                        endWidth: 15,
                      ),
                      GaugeRange(
                        startValue: 3.5,
                        endValue: 3.7,
                        color: Colors.white,
                        startWidth: 15,
                        endWidth: 15,
                      ),
                      GaugeRange(
                        startValue: 3.7,
                        endValue: 5,
                        color: Color(0xFF7B7DC7),
                        startWidth: 15,
                        endWidth: 15,
                      ),
                      GaugeRange(
                        startValue: 5,
                        endValue: 5.2,
                        color: Colors.white,
                        startWidth: 15,
                        endWidth: 15,
                      ),
                      GaugeRange(
                        startValue: 5.2,
                        endValue: 6.6,
                        color: Color.fromARGB(255, 62, 50, 97),
                        startWidth: 15,
                        endWidth: 15,
                      ),
                    ],
                    pointers: [
                      NeedlePointer(
                        value: double.parse(formattedScore),
                        needleLength: 0.6,
                        needleStartWidth: 1,
                        needleEndWidth: 1,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            formattedScore,
                            style: TextStyle(
                              fontSize:
                                  Get.width * 0.055, // Responsive font size
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.6,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

PerformanceGuagePointer({
  required String labelText,
  required String score,
  required double measurementValue,
  required String labelunit,
  required VoidCallback onTap,
  required double minValue,
  required double maxValue,
}) {
  // Make score 2 decimal places
  String formattedScore = double.parse(score).toStringAsFixed(2);
  double clampedValue = measurementValue.clamp(minValue, maxValue);

  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(Get.width * 0.02), // Margin is responsive
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02,
          horizontal: Get.width * 0.03, // Padding is responsive
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Label Text
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelText,
                    style: TextStyle(
                      fontSize: Get.width * 0.03, // Font size based on width
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    ImagePath.icNext,
                    height: Get.width * 0.03, // Image size based on width
                    width: Get.width * 0.03,
                  ),
                ],
              ),
            ),
            Text(
              labelunit,
              style: TextStyle(
                fontSize: Get.width * 0.022, // Font size based on width
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Container(
              width: Get.width,
              height: Get.height * 0.15, // Height based on screen height
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    radiusFactor: 0.8,
                    axisLineStyle: const AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor,
                      thickness: 0.45,
                    ),
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        angle: 180,
                        widget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              score,
                              style: TextStyle(
                                fontSize: Get.width * 0.03,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              ' / 100',
                              style: TextStyle(
                                fontSize: Get.width * 0.03,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: measurementValue,
                        enableAnimation: true,
                        animationDuration: 1200,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: SweepGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 62, 50, 97),
                            Color(0xFF7B7DC7)
                          ],
                          stops: <double>[0.25, 0.75],
                        ),
                        color: AppColors.white,
                        width: 0.45,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

LineraGuagePointer({
  required String heading,
  required double currentValue,
  required double minValue,
  required double maxValue,
  required String text1,
  required String text2,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(10), // Border radius for the whole container
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: EdgeInsets.all(Get.width * 0.02), // Responsive padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading Text with dynamic font size
        Padding(
          padding: EdgeInsets.only(
              bottom: Get.width * 0.01), // Space between heading and gauge
          child: Text(
            heading,
            style: TextStyle(
              fontSize: Get.width * 0.05, // Responsive font size
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        // Linear Gauge with border radius
        Container(
          height: Get.width * 0.2, // Responsive height based on screen width
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(12), // Border radius for the linear gauge
            color: Colors.white,
          ),
          child: SfLinearGauge(
            minimum: minValue,
            maximum: maxValue,
            orientation: LinearGaugeOrientation.horizontal,
            showLabels: false,
            showAxisTrack: false,
            showTicks: false,
            // Disable the scale labels
            ranges: [
              LinearGaugeRange(
                startValue: minValue,
                endValue: 20,
                color: Color(0xFFA5ABE2),
                startWidth: 20,
                endWidth: 20,
              ),
              LinearGaugeRange(
                startValue: 20,
                endValue: 40,
                color: Color(0xFFA9AAE4),
                startWidth: 20,
                endWidth: 20,
              ),
              LinearGaugeRange(
                startValue: 40,
                endValue: 60,
                color: Color(0xFF7B7DC7),
                startWidth: 20,
                endWidth: 20,
              ),
              LinearGaugeRange(
                startValue: 60,
                endValue: 80,
                color: Color(0xFF4A4CA3),
                startWidth: 20,
                endWidth: 20,
              ),
              LinearGaugeRange(
                startValue: 80,
                endValue: maxValue,
                color: Color(0xFF3D3260),
                startWidth: 20,
                endWidth: 20,
              ),
            ],
            markerPointers: [
              // Marker pointer for displaying the current value
              LinearShapePointer(
                value: currentValue,
                color: Colors.black,
                position: LinearElementPosition.outside,
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: TextStyle(
                fontSize: Get.width * 0.03, // Responsive font size
                color: Colors.black,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                fontSize: Get.width * 0.03, // Responsive font size
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

AverageCard({
  required String label,
  required String value,
  required VoidCallback onTap,
}) {
  {
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}

testValueContainer({
  required String text,
  required String value,
  required IconData icon,
  required VoidCallback onIconTap,
  required String modalText,
}) {
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: Colors.green),
              )
            ],
          ),
          InkWell(
            onTap: onIconTap, // Callback for the icon tap
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
