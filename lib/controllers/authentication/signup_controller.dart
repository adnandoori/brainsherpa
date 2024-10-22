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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignupController extends BaseController {
  static String stateId = 'signup_ui';

  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController textConfirmPasswordController = TextEditingController();
  TextEditingController textDateOfBirthController = TextEditingController();

  String? dropDownValue = AppStrings.male;

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child(AppConstants.userTable);
  var fcmToken = '';

  bool isChecked = false;

  int age = 0;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printf('<-----init-sign-up------>');

      printFCMKey();
    });
  }

  Future<void> selectDateOfBirth() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime(DateTime.now().year - 18),
        firstDate: DateTime(1901),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      printf(formattedDate);

      textDateOfBirthController.text = formattedDate;
      DateTime selectedDate =
          DateTime(pickedDate.year, pickedDate.month, pickedDate.day);

      DateTime todayDate = DateTime.now();

      age = todayDate.year - selectedDate.year;
      update([stateId]);
    }
  }

  void dropDownMenu(value) {
    dropDownValue = value;
    update([stateId]);
  }

  void buttonCheckbox(v) {
    isChecked = v!;
    update([stateId]);
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

            // Map<String, String> users = {
            //   'name': textName.text.trim(),
            //   'email': textEmail.text.trim(),
            //   'date': formattedDate,
            //   'time': '${now.hour}:${now.minute}:${now.second}',
            //   'timeStamp': now.millisecondsSinceEpoch.toString(),
            // };

            Map<String, String> users = {
              'name': textName.text.trim(),
              'email': textEmail.text.trim(),
              'dob': textDateOfBirthController.text.trim(),
              'gender': dropDownValue.toString(),
              'age': age.toString(),
              'token': fcmToken,
              'date': formattedDate,
              'time': '${now.hour}:${now.minute}:${now.second}',
              'timeStamp': now.millisecondsSinceEpoch.toString(),
            };

            printf('<---request-body--->$users');

            databaseReference.child(user.uid).set(users).whenComplete(() async {
              // loaderHide();
              // Utility.setUserName(textName.text.trim());
              // Get.offNamedUntil(Routes.dashboard, (route) => false);
              DataSnapshot snapshot =
                  await databaseReference.child(user.uid).get();
              if (snapshot.exists) {
                final data = Map<String, dynamic>.from(snapshot.value as Map);
                Utility.setUserDetails(jsonEncode(data));
                update([stateId]);
              }
              loaderHide();
              Get.offNamedUntil(Routes.dashboard, (route) => false);
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
