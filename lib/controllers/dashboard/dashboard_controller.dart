import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:flutter/material.dart';

class DashboardController extends BaseController {
  static String stateId = 'dashboard_ui';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('----init----dashboard----');
    });
  }
}
