import 'package:brainsherpa/utils/app_string.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

final nameValidator = MultiValidator([
  RequiredValidator(errorText: AppStrings.pleaseEnterName),
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: AppStrings.pleaseEnterPassword),
  MinLengthValidator(6, errorText: AppStrings.passwordShouldBeMore),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: AppStrings.pleaseEnterEmail),
  EmailValidator(errorText: AppStrings.pleaseEnterValidEmail),
]);
