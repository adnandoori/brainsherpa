import 'package:brainsherpa/controllers/authentication/signup_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/extension_classes.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:brainsherpa/utils/style.dart';
import 'package:brainsherpa/utils/utility.dart';
import 'package:brainsherpa/widgets/text_form_field.dart';
import 'package:brainsherpa/widgets/validations.dart';
import 'package:brainsherpa/widgets/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                                  padding:
                                      EdgeInsets.only(bottom: 20.h, left: 25.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                        Expanded(
                            child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                16.sbh,
                                AppTextField(
                                  label: AppStrings.name,
                                  hint: AppStrings.name,
                                  keyboardType: TextInputType.emailAddress,
                                  validators: nameValidator.call,
                                  inputFormatters: [NoLeadingSpaceFormatter()],
                                  controller: controller.textName,
                                ),
                                16.sbh,
                                // SizedBox(
                                //   height: 54.h,
                                //   child: Row(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Expanded(
                                //         child: Container(
                                //           margin: EdgeInsets.only(right: 5.w),
                                //           child: AppTextField(
                                //             label: 'Gender',
                                //             keyboardType: TextInputType.none,
                                //             // Prevent keyboard from opening
                                //             readOnly: true,
                                //             validators:
                                //                 dateOfBirthValidator.call,
                                //             hint: 'Gender',
                                //             onTap: () async {
                                //               // Open the dropdown in a dialog
                                //               String? selectedGender =
                                //                   await showDialog<String>(
                                //                 context: context,
                                //                 builder:
                                //                     (BuildContext context) {
                                //                   return AlertDialog(
                                //                     title: const Text(
                                //                         "Select Gender"),
                                //                     content:
                                //                         DropdownButton<String>(
                                //                       value: controller
                                //                           .dropDownValue,
                                //                       onChanged: (value) {
                                //                         controller.dropDownMenu(
                                //                             value);
                                //                         Navigator.of(context).pop(
                                //                             value); // Pass the selected value back
                                //                       },
                                //                       isExpanded: true,
                                //                       items: [
                                //                         AppStrings.male,
                                //                         AppStrings.female,
                                //                         AppStrings.other,
                                //                       ].map((String value) {
                                //                         return DropdownMenuItem<
                                //                             String>(
                                //                           value: value,
                                //                           child: Text(
                                //                             value,
                                //                             textAlign: TextAlign
                                //                                 .center,
                                //                             style:
                                //                                 poppinsTextStyle(
                                //                               color:
                                //                                   Colors.grey,
                                //                               size: 15.sp,
                                //                             ),
                                //                           ),
                                //                         );
                                //                       }).toList(),
                                //                     ),
                                //                   );
                                //                 },
                                //               );
                                //
                                //               // Set the selected value to the text field
                                //               if (selectedGender != null) {
                                //                 controller.textGender.text =
                                //                     selectedGender;
                                //               }
                                //             },
                                //             maxLength: 11,
                                //             inputFormatters: [
                                //               NoLeadingSpaceFormatter()
                                //             ],
                                //             controller: controller.textGender,
                                //           ),
                                //         ),
                                //       ),
                                //       Expanded(
                                //         child: Container(
                                //           // height: Get.height < 650 ? 53.h : 46.h,
                                //           margin: EdgeInsets.only(left: 5.w),
                                //           padding: EdgeInsets.only(
                                //             left: 10.w,
                                //             right: 10.w,
                                //           ),
                                //           decoration: BoxDecoration(
                                //               border: Border.all(
                                //                   color: AppColors.buttonColor,
                                //                   width: 1),
                                //               borderRadius:
                                //                   BorderRadius.circular(5)),
                                //           child: Center(
                                //             child: DropdownButton<String>(
                                //               alignment: Alignment.center,
                                //               value: controller.dropDownValue,
                                //               onChanged: (value) {
                                //                 controller.dropDownMenu(value);
                                //               },
                                //               underline: Container(),
                                //               isExpanded: true,
                                //               items: [
                                //                 AppStrings.male,
                                //                 AppStrings.female,
                                //                 AppStrings.other
                                //               ]
                                //                   .map<
                                //                       DropdownMenuItem<String>>(
                                //                     (String value) =>
                                //                         DropdownMenuItem<
                                //                             String>(
                                //                       value: value,
                                //                       child: Padding(
                                //                         padding:
                                //                             EdgeInsets.only(
                                //                                 top: 2.h),
                                //                         child: Text(value,
                                //                             textAlign: TextAlign
                                //                                 .center,
                                //                             style:
                                //                                 poppinsTextStyle(
                                //                               color:
                                //                                   Colors.grey,
                                //                               size: 15.sp,
                                //                             )),
                                //                       ),
                                //                     ),
                                //                   )
                                //                   .toList(),
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height: 54.h,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5.w),
                                          child: AppTextField(
                                            label: AppStrings.dateOfBirth,
                                            keyboardType: TextInputType.phone,
                                            readOnly: true,
                                            validators:
                                                dateOfBirthValidator.call,
                                            hint: AppStrings.dateOfBirth,
                                            onTap: () async {
                                              controller.selectDateOfBirth();
                                            },
                                            maxLength: 11,
                                            inputFormatters: [
                                              NoLeadingSpaceFormatter()
                                            ],
                                            controller: controller
                                                .textDateOfBirthController,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height:
                                              Get.height < 650 ? 53.h : 46.h,
                                          margin: EdgeInsets.only(left: 5.w),
                                          padding: EdgeInsets.only(
                                            left: 10.w,
                                            right: 10.w,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.buttonColor,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              alignment: Alignment.center,
                                              value: controller.dropDownValue,
                                              onChanged: (value) {
                                                controller.dropDownMenu(value);
                                              },
                                              underline: Container(),
                                              isExpanded: true,
                                              items: [
                                                AppStrings.male,
                                                AppStrings.female,
                                                AppStrings.other
                                              ]
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                    (String value) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.h),
                                                        child: Text(value,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                poppinsTextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              size: 15.sp,
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                16.sbh,
                                AppTextField(
                                  label: AppStrings.email,
                                  hint: AppStrings.email,
                                  keyboardType: TextInputType.emailAddress,
                                  validators: emailValidator.call,
                                  inputFormatters: [NoLeadingSpaceFormatter()],
                                  controller: controller.textEmail,
                                ),
                                16.sbh,
                                AppTextField(
                                  label: AppStrings.password,
                                  hint: AppStrings.password,
                                  obscureText: true,
                                  inputFormatters: [NoLeadingSpaceFormatter()],
                                  controller: controller.textPassword,
                                  validators: passwordValidator.call,
                                ),
                                16.sbh,
                                AppTextField(
                                  validators: (val) {
                                    if (controller.textConfirmPasswordController
                                            .text ==
                                        "") {
                                      return AppStrings
                                          .pleaseEnterConfirmPassword;
                                    }
                                    if (val != controller.textPassword.text) {
                                      return AppStrings
                                          .confirmPasswordNotMatching;
                                    }

                                    return null;
                                  },
                                  inputFormatters: [NoLeadingSpaceFormatter()],
                                  label: AppStrings.confirmPassword,
                                  hint: AppStrings.confirmPassword,
                                  keyboardAction: TextInputAction.done,
                                  controller:
                                      controller.textConfirmPasswordController,
                                  obscureText: true,
                                  onSubmit: (_) {},
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 5.h),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: controller.isChecked,
                                        onChanged: (v) {
                                          controller.buttonCheckbox(v);
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith(getColor),
                                      ),
                                      Expanded(
                                        child:
                                            //Text('I accept the terms and conditions'),
                                            Text.rich(TextSpan(
                                                text: AppStrings.iAcceptThe,
                                                style: poppinsTextStyle(
                                                  size: 14.sp,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      ' ${AppStrings.termsAndConditions}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontSize: 14.sp,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: AppColors
                                                          .buttonColor),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {}),
                                            ])),
                                      ),
                                    ],
                                  ),
                                ),
                                50.sbh,
                                Container(
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  height: 52.h,
                                  child: buttonWithoutShadow(
                                      title: AppStrings.continueText,
                                      onClick: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (controller.age >= 18) {
                                            if (controller.isChecked) {
                                              controller.callUserSignUp();
                                            } else {
                                              Utility().snackBarError(AppStrings
                                                  .pleaseAcceptTermsConditions);
                                            }
                                          } else {
                                            Utility().snackBarError(AppStrings
                                                .pleaseSelectProperDate);
                                          }
                                          //controller.callUserSignUp();
                                        }
                                        //printf('----clicked----continue--------');
                                      }),
                                )
                              ],
                            ),
                          ),
                        )),
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
