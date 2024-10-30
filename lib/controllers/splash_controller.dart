import 'dart:async';

import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  BuildContext context;

  SplashController(this.context);

  bool isUserLogin = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginOrNot();
      navigateToHomeScreen();
    });
  }

  void navigateToHomeScreen() {
    var duration = const Duration(
      seconds: 4,
    );
    Timer(duration, () async {
      if (isUserLogin) {
        Get.offNamedUntil(
            Routes.dashboard, arguments: ['login'], (route) => false);
      } else {
        Get.offNamedUntil(Routes.login, (route) => false);
      }
    });
  }

  void checkLoginOrNot() async {
    try {
      isUserLogin = (await Utility.getIsUserLoggedIn())!;
    } catch (e) {
      printf('<--exe--->$e');
    }
    printf('checkLogin->$isUserLogin');
  }
}
