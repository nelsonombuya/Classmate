// # Dart Imports
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_view_widget.dart';
import 'package:flutter/Material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();

  // # Useful Functions
  // * Sign Up
  Future<bool> signUp() async {
    await Future.delayed(Duration(seconds: 5));
    return false;
  }

  // * Sign Up Successful
  // Sends user to the sign in page
  signUpSuccessful() {}

  // * Sign Up Failed
  // Does stuff when sign up failed
  signUpFailed() {}
}

class _SignUpPageState extends State<SignUpPage> {
  // * Used to disable Fields and Buttons during Sign In
  bool areThingsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return View(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // # Sign Up Header Text
      CustomHeader(
        heading: 'SIGN UP',
        subheading: 'Create a new account',
      ),

      // # Sized Box for spacing
      SizedBox(
        height: 25.0,
      ),

      Form(
        child: Column(
          children: [
            // # Names
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Name
                Expanded(
                    child: CustomTextFormField(
                        label: 'First Name',
                        isEnabled: areThingsEnabled,
                        keyboardType: TextInputType.name)),

                // Spacing Between Fields
                SizedBox(
                  width: 30.0,
                ),

                // Last Name
                Expanded(
                  child: CustomTextFormField(
                      label: 'Last Name',
                      isEnabled: areThingsEnabled,
                      keyboardType: TextInputType.name),
                ),
              ],
            ),

            // # Sized Box for spacing
            SizedBox(
              height: 25.0,
            ),

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
              obscureText: true,
              isEnabled: areThingsEnabled,
              keyboardType: TextInputType.visiblePassword,
            ),

            // # Sized Box for spacing
            SizedBox(
              height: 25.0,
            ),

            // # Password Confirmation
            CustomTextFormField(
              label: 'Confirm Password',
              obscureText: true,
              isEnabled: areThingsEnabled,
              keyboardType: TextInputType.visiblePassword,
            ),

            // # Sized Box for spacing
            SizedBox(
              height: 70.0,
            ),

            // # Sign Up Button
            Center(
              child: CustomLoadingElevatedButton(
                child: Text('Sign In'),
                onPressed: () {
                  setState(() {
                    areThingsEnabled = false;
                  });
                  return widget.signUp();
                },
                onSuccess: widget.signUpSuccessful,
                onFailure: () {
                  setState(() {
                    areThingsEnabled = true;
                  });
                  return widget.signUpFailed;
                },
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
