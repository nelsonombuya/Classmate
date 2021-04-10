// # Dart Imports
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/pages/sign_in/forgot_password_widget.dart';
import 'package:classmate/presentation/pages/sign_in/sign_up_button_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_divider_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_view_widget.dart';
import 'package:classmate/constants/validators.dart';
import 'package:flutter/Material.dart';

// # Sign In Page
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();

  // # Useful Functions
  // * Sign In
  Future<bool> signIn() async {
    await Future.delayed(Duration(seconds: 5));
    return false;
  }
}

class _SignInPageState extends State<SignInPage> {
  // * Used to disable Fields and Buttons during ign In
  bool _areThingsEnabled = true;
  bool _showPassword = false;

  // * Form Key for Form Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // * Main App View
  @override
  Widget build(BuildContext context) {
    return View(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // # Sign In Header Text
          CustomHeader(
            heading: 'SIGN IN',
            subheading: 'Sign in to continue',
          ),

          // # Sized Box for spacing
          SizedBox(height: 25.0),

          // # Form
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                // # E-Mail Address Field
                CustomTextFormField(
                  label: 'E-Mail Address',
                  enabled: _areThingsEnabled,
                  validator: Validator.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),

                // # Sized Box for spacing
                SizedBox(height: 25.0),

                // # Password Field
                // FIXME Extract me please
                CustomTextFormField(
                  label: 'Password',
                  enabled: _areThingsEnabled,
                  obscureText: !_showPassword,
                  validator: Validator.passwordValidator,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: _showPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  suffixIconAction: () =>
                      setState(() => _showPassword = !_showPassword),
                ),

                // # Forgot Password
                ForgotPasswordWidget(areThingsEnabled: _areThingsEnabled),

                // # Sized Box for spacing
                SizedBox(height: 40.0),

                // # Sign In Button
                // ! Can't be extracted
                Center(
                  child: CustomLoadingElevatedButton(
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _areThingsEnabled = false;
                            _showPassword = false;
                          });
                          return widget.signIn();
                        }
                        return false;
                      },
                      onSuccess: () {},
                      onFailure: () =>
                          setState(() => _areThingsEnabled = true)),
                ),
              ],
            ),
          ),

          // # Sized Box for spacing
          SizedBox(height: 70.0),

          // # Divider for Coolness
          CustomDivider(text: 'OR'),

          // # Sized Box for spacing
          SizedBox(height: 60.0),

          // # Sign Up Button
          SignUpButton(areThingsEnabled: _areThingsEnabled),
        ],
      ),
    );
  }
}
