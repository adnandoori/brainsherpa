import 'package:brainsherpa/controllers/base_controller.dart';
import 'package:flutter/material.dart';

class SignupController extends BaseController {
  static String stateId = 'signup_ui';

  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
}
