import 'package:brainsherpa/controllers/authentication/signup_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/extension_classes.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:brainsherpa/widgets/text_form_field.dart';
import 'package:brainsherpa/widgets/validations.dart';
import 'package:brainsherpa/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final isElevated = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      init: SignupController(),
      id: SignupController.stateId,
      builder: (controller) {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.white,
                body: Form(
                  key: _formKey,
                  child: SizedBox(
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonAppbarWithAppName(),
                            SizedBox(
                              height: 150.h,
                              width: Get.width,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    ImagePath.loginBackground,
                                    height: 150.h,
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.h, left: 25.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.signUp,
                                            style: poppinsTextStyle(
                                                size: 32.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  16.sbh,
                                  AppTextField(
                                    label: AppStrings.email,
                                    hint: AppStrings.email,
                                    keyboardType: TextInputType.emailAddress,
                                    validators: emailValidator.call,
                                    inputFormatters: [
                                      NoLeadingSpaceFormatter()
                                    ],
                                    controller: controller.textEmail,
                                  ),
                                  16.sbh,
                                  AppTextField(
                                    label: AppStrings.password,
                                    hint: AppStrings.password,
                                    obscureText: true,
                                    inputFormatters: [
                                      NoLeadingSpaceFormatter()
                                    ],
                                    controller: controller.textPassword,
                                    validators: passwordValidator.call,
                                  ),
                                  16.sbh,
                                ],
                              ),
                            )
                          ],
                        )),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h),
                          height: 52.h,
                          child: buttonWithoutShadow(
                              title: AppStrings.continueText,
                              onClick: () {
                                printf('----clicked----continue--------');
                              }),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
