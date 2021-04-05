// # Dart Imports
import 'package:classmate/presentation/widgets/custom_divider_widget.dart';
import 'package:classmate/presentation/widgets/custom_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_view_widget.dart';
import 'package:flutter/Material.dart';

// # Sign In Page
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return View(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // # Welcome Header Text
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
                  keyboardType: TextInputType.emailAddress),

              // # Sized Box for spacing
              SizedBox(
                height: 25.0,
              ),

              // # Password
              CustomTextFormField(
                  label: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true),

              // # Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.blue),
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
                    onPressed: () => true,
                    onSuccess: () {},
                    onFailure: () {},
                    child: Text('Sign In',
                        style: Theme.of(context).textTheme.button)),
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
                onPressed: () {},
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
