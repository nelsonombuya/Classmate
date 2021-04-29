import 'package:string_validator/string_validator.dart';

/// ### Validator
/// Has common static functions that can be used for input validation
/// TODO Implement proper error handling ❗
abstract class Validator {
  static String? emailValidator(String? value) {
    if (value == null) throw Exception("Can't validate null string. ❗");
    return isEmail(value) ? null : 'Please enter valid email address';
  }

  static String? nameValidator(String? value) {
    if (value == null) throw Exception("Can't validate null string. ❗");

    if (value.length < 1) return 'Please input a name';

    if (value[0] == " ") return 'Remove the space before your name';

    if (value[0] != value[0].toUpperCase())
      return 'Please capitalize the first letter in your name.';

    return isAlpha(value) ? null : "Please don't input a number";
  }

  static String? passwordValidator(String? value) {
    if (value == null) throw Exception("Can't validate null string. ❗");
    if (value.isEmpty) return 'Please input a password';
    return (value.length >= 8) ? null : 'Password is too short';
  }

  static String? securePasswordValidator(String? value) {
    if (value == null) throw Exception("Can't validate null string. ❗");
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    return RegExp(pattern).hasMatch(value)
        ? null
        : '''Please enter a password with:
          Minimum 1 Upper case
          Minimum 1 lowercase
          Minimum 1 Numeric Number
          Minimum 1 Special Character ( ! @ # \$ & * ~ )''';
  }

  static String? titleValidator(String? value) {
    if (value == null) throw Exception("Can't validate null string. ❗");
    return (value.isEmpty) ? 'Please input a title' : null;
  }
}

/// ### Confirm Password Validator
/// Extends the Validator Class
/// Used when you want to confirm the user's input password
/// Initialize this class in the form
/// and set the value of initial password to the first password set
/// Then use the function confirmPasswordValidator on the
/// Confirm Password Field
class PasswordConfirmationValidator extends Validator {
  String initialPassword = '';

  String? confirmPasswordValidator(passwordConfirmation) {
    String? normalPasswordValidation =
        Validator.passwordValidator(passwordConfirmation);

    if (normalPasswordValidation != null) return normalPasswordValidation;

    return passwordConfirmation == initialPassword
        ? null
        : 'Passwords do not match';
  }
}
