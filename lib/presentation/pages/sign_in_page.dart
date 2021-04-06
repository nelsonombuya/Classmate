// # Dart Imports
import 'package:classmate/presentation/widgets/custom_divider_widget.dart';
import 'package:classmate/presentation/widgets/custom_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_view_widget.dart';
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

  // * Sign Up
  // Sends the user to the Sign Up Page
  signUp() {}

  // * Forgot Password
  // Sends user to forgot password page
  forgotPassword() {}

  // * Sign In Successful
  // Sends user to the dashboard
  signInSuccessful() {}

  // * Sign In Failed
  // Does stuff when sign in failed
  signInFailed() {}
}

class _SignInPageState extends State<SignInPage> {
  // * Used to disable Fields and Buttons during Sign In
  bool areThingsEnabled = true;

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
        SizedBox(
          height: 25.0,
        ),

        // # Form
        Form(
          child: Column(
            children: [
              // # Email
              CustomTextFormField(
                  label: 'Email Address',
                  isEnabled: areThingsEnabled,
                  keyboardType: TextInputType.emailAddress),

              // # Sized Box for spacing
              SizedBox(
                height: 25.0,
              ),

              // # Password
              CustomTextFormField(
                  label: 'Password',
                  isEnabled: areThingsEnabled,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true),

              // # Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed:
                          areThingsEnabled ? widget.forgotPassword : null,
                      child: Text(
                        'Forgot Password?',
                      )),
                ],
              ),

              // # Sized Box for spacing
              SizedBox(
                height: 40.0,
              ),

              // # Sign In Button
              Center(
                child: CustomLoadingElevatedButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    setState(() {
                      areThingsEnabled = false;
                    });
                    return widget.signIn();
                  },
                  onSuccess: widget.signInSuccessful,
                  onFailure: () {
                    setState(() {
                      areThingsEnabled = true;
                    });
                    return widget.signInFailed;
                  },
                ),
              ),
            ],
          ),
        ),

        // # Sized Box for spacing
        SizedBox(
          height: 70.0,
        ),

        // # Divider for Coolness
        CustomDivider(text: 'OR'),

        /// TODO Add Sign In With Google Button
        // # Sized Box for spacing
        SizedBox(
          height: 60.0,
        ),

        // # Sign Up Button
        Center(
          child: Column(
            children: [
              CustomElevatedButton(
                onPressed: areThingsEnabled ? widget.signUp : null,
                child:
                    Text('Sign Up', style: Theme.of(context).textTheme.button),
              ),

              SizedBox(
                height: 20,
              ),

              // Some Text
              Text('To create a new account.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
      ],
    ));
  }
}
