// # Dart Imports
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_form_view_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/constants/validators.dart';
import 'package:relative_scale/relative_scale.dart';
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
}

class _SignUpPageState extends State<SignUpPage> {
  // * Used to disable Fields and Buttons during Sign In
  String _temporaryPasswordHolder;
  bool _areThingsEnabled = true;
  bool _showPassword = false;

  // * Form Keys for Form Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // * For Validating Confirm Password
  String confirmPasswordValidator(password) {
    // Normal Password Validation
    String initialValidation = Validator.passwordValidator(password);

    // If initial validation succeeded, check whether the passwords match
    if (initialValidation == null)
      return password == _temporaryPasswordHolder
          ? null
          : 'Password do not match';

    // If initial validation failed, return that state
    return initialValidation;
  }

  @override
  Widget build(BuildContext context) {
    return FormView(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // # Sign Up Header Text
              CustomHeader(
                heading: 'SIGN UP',
                subheading: 'Create a new account',
              ),

              // # Sized Box for spacing
              SizedBox(height: sy(15.0)),

              // # Form
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            enabled: _areThingsEnabled,
                            keyboardType: TextInputType.name,
                            validator: Validator.nameValidator,
                          ),
                        ),

                        // Spacing Between Fields
                        SizedBox(width: sx(20.0)),

                        // Last Name
                        Expanded(
                          child: CustomTextFormField(
                            label: 'Last Name',
                            enabled: _areThingsEnabled,
                            keyboardType: TextInputType.name,
                            validator: Validator.nameValidator,
                          ),
                        ),
                      ],
                    ),

                    // # Sized Box for spacing
                    SizedBox(height: sy(15.0)),

                    // # Email
                    CustomTextFormField(
                      label: 'Email Address',
                      enabled: _areThingsEnabled,
                      validator: Validator.emailValidator,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    // # Sized Box for spacing
                    SizedBox(height: sy(15.0)),

                    // # Password
                    CustomTextFormField(
                      label: 'Password',
                      enabled: _areThingsEnabled,
                      onChanged: (value) =>
                          setState(() => _temporaryPasswordHolder = value),
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
                    SizedBox(height: sy(15.0)),

                    // # Password Confirmation
                    CustomTextFormField(
                      label: 'Confirm Password',
                      enabled: _areThingsEnabled,
                      obscureText: !_showPassword,
                      validator: confirmPasswordValidator,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: _showPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      suffixIconAction: () =>
                          setState(() => _showPassword = !_showPassword),
                    ),

                    // # Sized Box for spacing
                    SizedBox(height: sy(40.0)),

                    // # Sign Up Button
                    Center(
                      child: CustomLoadingElevatedButton(
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(fontSize: sy(9)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _showPassword = false;
                              _areThingsEnabled = false;
                            });
                            return widget.signUp();
                          }
                          return false;
                        },
                        onSuccess: () {},
                        onFailure: () =>
                            setState(() => _areThingsEnabled = true),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
