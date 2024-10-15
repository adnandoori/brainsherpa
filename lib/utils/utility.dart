import 'package:brainsherpa/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class Utility {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool isValidMobileNumber(String mobileNumber) {
    // Define a regular expression pattern for a typical 10-digit mobile number.
    RegExp regex = RegExp(r'^(?:\+?\d{1,3})?[0-9]{10}$');
    return regex.hasMatch(mobileNumber);
  }


}
