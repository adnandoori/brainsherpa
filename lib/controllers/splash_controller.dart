import 'dart:async';

import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
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
      navigateToHomeScreen();
    });
  }

  void navigateToHomeScreen() {
    var duration = const Duration(
      seconds: 4,
    );
    Timer(duration, () async {
      Get.offNamedUntil(Routes.login, (route) => false);
    });
  }
}
