import 'dart:convert';

import 'package:brainsherpa/models/authentication_model/user_model.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/style.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';

class Utility {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      if (kDebugMode) {
        print('Internet mode : mobile');
      }
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      if (kDebugMode) {
        print('Internet mode : wifi');
      }
      return true;
    }
    return false;
  }

  static setIsUserLoggedIn(bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppConstants.isLogin, value);
  }

  static Future<bool?> getIsUserLoggedIn() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(AppConstants.isLogin);
  }

  static setUserId(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppConstants.userId, value);
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(AppConstants.userId);
    return userId!;
  }

  static setUserName(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppConstants.userName, value);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(AppConstants.userName);
    return userId!;
  }

  static Future<void> setUserDetails(String userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userDetails', userDetails);
  }

  static Future<UserModel?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userDetails');
    printf('--user-detail-->$userData');
    if (userData != null && userData.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(userData));
    } else {
      return null;
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool isValidMobileNumber(String mobileNumber) {
    // Define a regular expression pattern for a typical 10-digit mobile number.
    RegExp regex = RegExp(r'^(?:\+?\d{1,3})?[0-9]{10}$');
    return regex.hasMatch(mobileNumber);
  }

  void clearSession() {
    Utility.setIsUserLoggedIn(false);
    Utility.setUserName('');
    Utility.setUserId('');
  }

  void snackBarError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor:
            msg == AppStrings.internetError //''AppConstants.noInternet
                ? Colors.red
                : AppColors.buttonColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void snackBarForInternetIssue() {
    Fluttertoast.showToast(
        msg: AppStrings.internetError,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void snackBarSuccess(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
