import 'package:string_validator/string_validator.dart';

/// # Validator
/// Used during form validations
abstract class Validator {
  // * E-Mail Validation Rules
  static String emailValidator(String value) =>
      isEmail(value) ? null : 'Please enter valid email address';

  // * Name Validation Rules
  static String nameValidator(String value) {
    if (value.length < 1) return 'Please input a name';

    if (value[0] == " ") return 'Remove the space before your name';

    if (value[0] != value[0].toUpperCase())
      return 'Please capitalize the first letter in your name.';

    return isAlpha(value) ? null : "Please don't input a number";
  }

  // * Validation for simple passwords
  static String passwordValidator(String value) {
    if (value.isEmpty) return 'Please input a password';
    return (value.length >= 8) ? null : 'Password is too short';
  }

  // * Validation for more secure passwords
  static String securePasswordValidator(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value)
        ? null
        : '''Please enter a password with:
          Minimum 1 Upper case
          Minimum 1 lowercase
          Minimum 1 Numeric Number
          Minimum 1 Special Character ( ! @ # \$ & * ~ )''';
  }

  // * Title Validator
  static String titleValidator(String value) {
    return (value.isEmpty) ? 'Please input a title' : null;
  }
}

/// # Confirm Password Validator
/// Extends the Validator Class
/// Used when you want to confirm the user's input password
class PasswordConfirmationValidator extends Validator {
  String temp;

  String confirmPasswordValidator(password) {
    // Normal Password Validation
    String initialValidation = Validator.passwordValidator(password);

    // If initial validation succeeded, check whether the passwords match
    if (initialValidation == null)
      return password == temp ? null : 'Passwords do not match';

    // If initial validation failed, return that state
    return initialValidation;
  }
}
