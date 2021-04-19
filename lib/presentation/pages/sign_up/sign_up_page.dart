// # Dart Imports
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/widgets/custom_form_view_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/bloc/registration/registration_bloc.dart';
import 'package:classmate/constants/validators.dart';
import 'package:classmate/bloc/auth/auth_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/Material.dart';
import 'dart:async';

// # BlocProvider for the Page
class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (context) => RegistrationBloc(),
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // * Used to disable Fields and Buttons during Sign In
  bool _areThingsEnabled = true;
  bool _showPassword = false;
  bool _proceed;

  // * Used during password confirmation validation
  var _passwordConfirmation = PasswordConfirmationValidator();

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    RegistrationBloc _registrationBloc =
        BlocProvider.of<RegistrationBloc>(context);
    AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          setState(() => _proceed = true);
          _authBloc.add(AuthStarted());
        }

        if (state is RegistrationFailure) {
          setState(() => _proceed = false);
          Flushbar(
            title: "Sign In Failed",
            message: state.message,
            duration: Duration(seconds: 5),
          )..show(context);
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
                    child: BlocBuilder<RegistrationBloc, RegistrationState>(
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

                              // Running the registration started event
                              _registrationBloc.add(
                                RegistrationStarted(
                                  email: _email,
                                  password: _password,
                                ),
                              );

                              /// HACK Used to sync the current states
                              /// With the sign up button animations
                              while (_proceed == null)
                                await Future.delayed(Duration(seconds: 3));

                              bool result = _proceed;
                              setState(() => _proceed = null);

                              return result;
                            }
                          },
                          onEnd: () {
                            if (_proceed == null)
                              setState(() => _areThingsEnabled = true);

                            if (_proceed == true)
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
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
