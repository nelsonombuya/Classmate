import 'package:string_validator/string_validator.dart';

class Validator {
  // * The E-Mail Validation Rules
  static String emailValidator(String value) =>
      isEmail(value) ? null : 'Please enter valid email address';

  // * Safe for more secure passwords
  static String safePasswordValidator(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value)
        ? null
        : '''Please enter a password with:
          Minimum 1 Upper case
          Minimum 1 lowercase
          Minimum 1 Numeric Number
          Minimum 1 Special Character
          Common Allow Character ( ! @ # \$ & * ~ )''';
  }

  // * Simple for simple passwords
  static String passwordValidator(String value) =>
      (value.length > 8) ? null : 'Password is too short';

  static String nameValidator(String value) =>
      isAlpha(value) ? null : 'Please don\'t input a number';
}
