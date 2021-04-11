// # Dart Imports
import 'package:classmate/constants/device.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/pages/sign_in/forgot_password_widget.dart';
import 'package:classmate/presentation/pages/sign_in/sign_up_button_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/pages/sign_in/custom_divider_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_form_view_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return FormView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // # Sign In Header Text
        CustomHeader(
          heading: 'SIGN IN',
          subheading: 'Sign in to continue',
        ),

        // # Sized Box for spacing
        SizedBox(height: Device.height(2.0)),

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
              SizedBox(height: Device.height(3.0)),

              // # Password Field
              // ! Can't be extracted
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

              // # Sized Box for spacing
              SizedBox(height: Device.height(1.0)),

              // # Forgot Password
              ForgotPasswordWidget(enabled: _areThingsEnabled),

              // # Sized Box for spacing
              SizedBox(height: Device.height(7.0)),

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
                          _showPassword = false;
                          _areThingsEnabled = false;
                        });
                        return widget.signIn(); // ! Should return bool
                      }
                      return false;
                    },
                    onSuccess: () {}, // TODO Navigate to Dashboard
                    onFailure: () => setState(() => _areThingsEnabled = true)),
              ),
            ],
          ),
        ),

        // # Sized Box for spacing
        SizedBox(height: Device.height(8.0)),

        // # Divider for Coolness
        CustomDivider(text: 'OR'),

        // # Sized Box for spacing
        SizedBox(height: Device.height(8.0)),

        // # Sign Up Button
        SignUpButton(enabled: _areThingsEnabled),
      ],
    ));
  }
}
