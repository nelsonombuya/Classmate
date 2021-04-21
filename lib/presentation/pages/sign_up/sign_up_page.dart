// # Dart Imports
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_form_view_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/presentation/widgets/custom_snack_bar.dart';
import 'package:classmate/bloc/sign_up/sign_up_bloc.dart';
import 'package:classmate/constants/validators.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/Material.dart';
import 'dart:async';

// # BlocProvider for the Page
class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: SignUp(),
    );
  }
}

// # Sign Up Page
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _firstName, _lastName, _email, _password;

  // * Global Key for Form Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // * Used to disable Fields and Buttons during Sign In
  bool _areThingsEnabled = true;
  bool _showPassword = false;
  bool _proceed;

  // * Used during password confirmation validation
  var _passwordConfirmation = PasswordConfirmationValidator();

  @override
  Widget build(BuildContext context) {
    SignUpBloc _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    Device().init(context);

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) setState(() => _proceed = true);

        if (state is SignUpFailure) {
          setState(() => _proceed = false);
          CustomSnackBar(
            context,
            title: "Sign Up Failed",
            message: state.message,
            type: NotificationType.Error,
          );
        }
      },
      child: FormView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // # Sign Up Header Text
            CustomHeader(
              heading: 'SIGN UP',
              subheading: 'Create a new account',
            ),

            // # Sized Box for spacing
            SizedBox(height: Device.height(2.0)),

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
                          onSaved: (value) => _firstName = value,
                        ),
                      ),

                      // Spacing Between Fields
                      SizedBox(width: Device.width(4.0)),

                      // Last Name
                      Expanded(
                          child: CustomTextFormField(
                        label: 'Last Name',
                        enabled: _areThingsEnabled,
                        keyboardType: TextInputType.name,
                        validator: Validator.nameValidator,
                        onSaved: (value) => _lastName = value,
                      )),
                    ],
                  ),

                  // # Sized Box for spacing
                  SizedBox(height: Device.height(3.0)),

                  // # Email
                  CustomTextFormField(
                    label: 'Email Address',
                    enabled: _areThingsEnabled,
                    onSaved: (value) => _email = value,
                    validator: Validator.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // # Sized Box for spacing
                  SizedBox(height: Device.height(3.0)),

                  // # Password
                  CustomTextFormField(
                    label: 'Password',
                    enabled: _areThingsEnabled,
                    obscureText: !_showPassword,
                    onSaved: (value) => _password = value,
                    validator: Validator.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () =>
                        setState(() => _showPassword = !_showPassword),
                    onChanged: (value) =>
                        setState(() => _passwordConfirmation.temp = value),
                  ),

                  // # Sized Box for spacing
                  SizedBox(height: Device.height(3.0)),

                  // # Password Confirmation
                  CustomTextFormField(
                    label: 'Confirm Password',
                    enabled: _areThingsEnabled,
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () =>
                        setState(() => _showPassword = !_showPassword),
                    validator: _passwordConfirmation.confirmPasswordValidator,
                  ),

                  // # Sized Box for spacing
                  SizedBox(height: Device.height(8.0)),

                  // # Sign Up Button
                  Center(
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        return CustomLoadingElevatedButton(
                          onPressed: () async {
                            // Validating the form input
                            if (_formKey.currentState.validate()) {
                              setState(
                                // Locking the fields
                                () {
                                  _showPassword = false;
                                  _areThingsEnabled = false;
                                },
                              );

                              // Saving the form information for use during sign up
                              _formKey.currentState.save();

                              // Running the SignUp started event
                              _signUpBloc.add(
                                SignUpStarted(
                                  email: _email,
                                  password: _password,
                                ),
                              );

                              /// HACK Used to sync the current states
                              /// With the sign up button animations
                              while (_proceed == null)
                                await Future.delayed(Duration(seconds: 3));

                              return _proceed;
                            }
                          },
                          onEnd: () {
                            if (_proceed == true) {
                              setState(() => _proceed = null);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            } else {
                              setState(() {
                                _proceed = null;
                                _areThingsEnabled = true;
                              });
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.button,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
