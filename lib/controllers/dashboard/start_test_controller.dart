import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartTestController extends BaseController {
  static String stateId = 'start_test_ui';

  double currentRatingForFirst = 1;
  String isSelected = "No";

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----StartTestController---->');
    });
  }

  void buttonStart() {
    if (isSelected.isEmpty) {
    } else {
      printf('----first--->$currentRatingForFirst');

      printf('----selected--->$isSelected');
      navigateToReactionTest();
    }
  }

  Future<void> navigateToReactionTest() async {
    printf('<---navigate-to-reactionTimeTestScreen--->');
    final result = await Get.toNamed(Routes.reactionTimeTestScreen,
        arguments: [currentRatingForFirst, isSelected]);

    printf('<---result--->$result');
    if (result != null) {
      Get.back(result: true);
    }
  }

  void changeRatingForFirst(v) {
    printf('-----rating--first--->$v');
    currentRatingForFirst = v;
    update([stateId]);
  }


  void clickSelected(v) {
    printf('-----selected--->$v');
    isSelected = v;
    update([stateId]);
  }
}
