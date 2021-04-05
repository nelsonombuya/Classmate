// # Dart Imports
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_view_widget.dart';
import 'package:flutter/Material.dart';

class SignUpPage extends StatelessWidget {
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

      // # Names
      Form(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Name
                Expanded(
                    child: CustomTextFormField(
                        label: 'First Name', keyboardType: TextInputType.name)),

                // Spacing Between Fields
                SizedBox(
                  width: 30.0,
                ),

                // Last Name
                Expanded(
                  child: CustomTextFormField(
                      label: 'Last Name', keyboardType: TextInputType.name),
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
                keyboardType: TextInputType.emailAddress),

            // # Sized Box for spacing
            SizedBox(
              height: 25.0,
            ),

            // # Password
            CustomTextFormField(
              label: 'Password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            // # Sized Box for spacing
            SizedBox(
              height: 25.0,
            ),
            // # Password Confirmation

            CustomTextFormField(
              label: 'Confirm Password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            // # Sized Box for spacing
            SizedBox(
              height: 70.0,
            ),

            // # Sign Up Button
            Center(
                child: CustomLoadingElevatedButton(
                    onPressed: () {},
                    onSuccess: () {},
                    onFailure: () {},
                    child: Text('Sign Up',
                        style: Theme.of(context).textTheme.button))),
          ],
        ),
      )
    ]));
  }
}
