import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  static String stateId = 'login_ui';

  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool isButtonEnable = false;
  bool checkEmail = false;
  bool checkPassword = false;

  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('----init----login-controller----------');
    });
  }

  void callLogin() {
    Get.toNamed(Routes.dashboard);
  }
}
