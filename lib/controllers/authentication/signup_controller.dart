import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:brainsherpa/fcm/authentication_helper.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignupController extends BaseController {
  static String stateId = 'signup_ui';

  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.userTable);
  var fcmToken = '';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<-----init-sign-up------>');
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

  @override
  void onClose() {
    printf('<----close-sign-up------>');
    super.onClose();
  }

  void callUserSignUp() {
    Utility.isConnected().then((value) {
      if (value) {
        loaderShow();
        AuthenticationHelper()
            .signUp(
                email: textEmail.text.trim(),
                password: textPassword.text.trim())
            .then((result) {
          if (result == null) {
            User user = AuthenticationHelper().user;
            printf('<-----success-register--->${user.uid}');
            Utility.setIsUserLoggedIn(true);
            Utility.setUserId(user.uid);

            var now = DateTime.now();
            var formatter = DateFormat('dd-MMM-yyyy');
            String formattedDate = formatter.format(now);
            // var formatterMonth = DateFormat('MMM, yyyy');

            Map<String, String> users = {
              'name': textName.text.trim(),
              'email': textEmail.text.trim(),
              'date': formattedDate,
              'time': '${now.hour}:${now.minute}:${now.second}',
              'timeStamp': now.millisecondsSinceEpoch.toString(),
            };

            printf('<---request-body--->$users');

            databaseReference.child(user.uid).set(users).whenComplete(() {
              loaderHide();
              Utility.setUserName(textName.text.trim());
              Get.toNamed(Routes.dashboard);
            });
          } else {
            printf('<--error--sign-up-->$result');
            loaderHide();
            Utility().snackBarError(result.toString());
          }
        });
      } else {
        Utility().snackBarForInternetIssue();
      }
    });
  }
}
