import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/fcm/authentication_helper.dart';
import 'package:brainsherpa/models/authentication_model/user_model.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  static String stateId = 'dashboard_ui';

  var username = '';
  late UserModel userModel;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<----init----DashboardController---->');
      getUserDetails();
    });
  }

  void getUserDetails() {
    try {
      Utility.getUserDetails().then((value) {
        if (value != null) {
          userModel = value;

          username = userModel.name.toString();
          update([stateId]);
        }
      });
    } catch (e) {
      printf('<----exe-userDetails-->$e');
      getUsername();
    }
  }

  void getUsername() async {
    printf('<---get_username----->');
    try {
      username = await Utility.getUserName();
      printf('username---->$username');
      update([stateId]);
    } catch (exe) {
      printf('<---exe-username--->$exe');
    }
  }

  void navigateToReactionTest() {
    printf('<---navigate-to-reactionTimeTestScreen--->');
    Get.toNamed(Routes.reactionTimeTestScreen);
  }

  void callLogout() {
    loaderShow();
    update([stateId]);
    AuthenticationHelper().signOut().whenComplete(() {
      printf('<---Logout---->');
      Get.back();
      Utility().snackBarSuccess(AppStrings.successFullyLogout);
      Utility.setIsUserLoggedIn(false);
      Utility.setUserId('');
      Get.deleteAll();
      Get.offNamedUntil(Routes.login, (route) => false);
      loaderHide();
    });
  }
}
