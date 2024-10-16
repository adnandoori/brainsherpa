import 'dart:convert';

import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/fcm/authentication_helper.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.userTable);

  var fcmToken = '';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('----init----login-controller----------');
      printFCMKey();
    });
  }

  printFCMKey() async {
    try {
      fcmToken = (await FirebaseMessaging.instance.getToken())!;
    } catch (e) {
      printf('fcm-token-$fcmToken');
    }
    printf('fcmToken-$fcmToken');
  }

  void callLogin() {
    Utility.isConnected().then((value) {
      if (value) {
        loaderShow();

        AuthenticationHelper()
            .signIn(
                email: textEmail.text.trim(),
                password: textPassword.text.trim())
            .then((result) {
          if (result == null) {
            User user = AuthenticationHelper().user;
            printf('<----success-login--->${user.uid}');
            Utility.setIsUserLoggedIn(true);

            Utility.setUserId(user.uid);
            var userId = user.uid;
            //

            setUserDetails(userId).whenComplete(() {
              loaderHide();
              Get.offNamedUntil(Routes.dashboard, (route) => false);
            });
          } else {
            printf('<---error-login-->$result');
            loaderHide();
            Utility().snackBarError(result.toString());
          }
        });
      } else {
        Utility().snackBarForInternetIssue();
      }
    });
  }

  Future<void> setUserDetails(String userId) async {
    if (userId.isNotEmpty) {
      databaseReference.child(userId).update({'token': fcmToken});
      DataSnapshot snapshot = await databaseReference.child(userId).get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        Utility.setUserDetails(jsonEncode(data));
        update([stateId]);
      }
    }
  }
}
