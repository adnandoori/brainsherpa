import 'package:brainsherpa/controllers/authentication/login_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
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

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final isElevated = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: LoginController.stateId,
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
                              height: 200.h,
                              width: Get.width,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    ImagePath.loginBackground,
                                    height: 200.h,
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 25.h, left: 25.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.hey,
                                            style: poppinsTextStyle(
                                                size: 32.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppStrings.notAMember,
                                                style: poppinsTextStyle(
                                                    size: 16.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  printf(
                                                      '---clicked---sign-up----');
                                                  Get.toNamed(Routes.signUp);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.w),
                                                  child: Text(
                                                    AppStrings.signUp,
                                                    style: poppinsTextStyle(
                                                        size: 16.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
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
                              title: AppStrings.login,
                              onClick: ()
                              {
                                if (_formKey.currentState!.validate()) {
                                  controller.callLogin();
                                }
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
