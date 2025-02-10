import 'package:brainsherpa/controllers/dashboard/start_test_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/extension_classes.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartTestScreen extends StatelessWidget {
  const StartTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: GetBuilder<StartTestController>(
          init: StartTestController(),
          id: StartTestController.stateId,
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widgetAppBar(title: AppStrings.reactionTimeTest),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: widgetSlider(
                            question: '1.',
                            title: AppStrings.questionFirst,
                            value: controller.currentRatingForFirst,
                            onChanged: (v) {
                              controller.changeRatingForFirst(v);
                            }),
                      ),
                      30.sbh,
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2.',
                                style: poppinsTextStyle(
                                    size: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              6.sbw,
                              Expanded(
                                child: Text(
                                  AppStrings.questionSecond,
                                  style: poppinsTextStyle(
                                      size: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: RadioListTile(
                                activeColor: AppColors.blueColor,
                                title: const Text(AppStrings.yes),
                                contentPadding: const EdgeInsets.all(0),
                                value: "Yes",
                                groupValue: controller.isSelected,
                                onChanged: (v) {
                                  controller.clickSelected(v);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              child: RadioListTile(
                                activeColor: AppColors.blueColor,
                                title: const Text(AppStrings.no),
                                value: "No",
                                contentPadding: const EdgeInsets.all(0),
                                groupValue: controller.isSelected,
                                onChanged: (v) {
                                  controller.clickSelected(v);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Colors.black, width: 0.5),
                        ),
                        child: TextField(
                          controller: controller.textNotes,
                          maxLines: 5,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            hintText: 'Put your notes here',
                            labelStyle: poppinsTextStyle(
                                size: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            hintStyle: poppinsTextStyle(
                                size: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 20.h, top: 20.h, left: 20.w, right: 20.w),
                    height: 52.h,
                    child: buttonDefault(
                        title: AppStrings.start,
                        onClick: () {
                          controller.buttonStart();
                        }),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetSlider(
      {required String question,
      required String title,
      required double value,
      required ValueChanged<double> onChanged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: poppinsTextStyle(
                      size: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                6.sbw,
                Expanded(
                  child: Text(
                    title,
                    style: poppinsTextStyle(
                        size: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            )),
        5.sbh,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SliderTheme(
            data: SliderTheme.of(Get.context!).copyWith(
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Colors.white,
              overlayColor: Colors.blue.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              trackHeight: 10,
            ),
            child: Slider(
              thumbColor: AppColors.blueColor,
              value: value,
              //controller.currentRating,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: onChanged,
              //     (v) {
              //   controller.changeRating(v);
              // },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widgetTextNumber('1'),
              widgetTextNumber('2'),
              widgetTextNumber('3'),
              widgetTextNumber('4'),
              widgetTextNumber('5'),
            ],
          ),
        ),
        6.sbh,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Poor", textAlign: TextAlign.center),
              Text("Excellent", textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }

  Widget widgetTextNumber(String number) {
    return Text(
      number,
      textAlign: TextAlign.center,
      style: poppinsTextStyle(
          fontWeight: FontWeight.w500, color: Colors.black, size: 16.sp),
    );
  }
}
