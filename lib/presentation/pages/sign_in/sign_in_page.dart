// # Dart Imports
import 'package:classmate/bloc/sign_in/sign_in_bloc.dart';
import 'package:classmate/constants/device.dart';
import 'package:classmate/constants/validators.dart';
import 'package:classmate/presentation/pages/sign_in/custom_divider_widget.dart';
import 'package:classmate/presentation/pages/sign_in/forgot_password_widget.dart';
import 'package:classmate/presentation/pages/sign_in/sign_up_button_widget.dart';
import 'package:classmate/presentation/widgets/custom_form_view_widget.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/widgets/custom_snack_bar.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// # Sign In Page
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(),
      child: SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // * Info collected from the Form
  String _email, _password;

  // * Used to disable Fields and Buttons during sign In
  bool _areThingsEnabled = true;
  bool _showPassword = false;
  bool _proceed;

  // * Form Key for Form Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Device().init(context);

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) async {
        if (state is SignInSuccess) setState(() => _proceed = true);

        if (state is SignInFailure) {
          setState(() => _proceed = false);
          CustomSnackBar(
            context,
            message: state.message,
            title: "Sign In Failed",
            type: NotificationType.Error,
          );
        }
      },
      child: FormView(
        title: "Sign In",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    onSaved: (value) => _email = value,
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
                    onSaved: (value) => _password = value,
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _showPassword = false;
                            _areThingsEnabled = false;
                          });

                          // Saving the form information for use during sign up
                          _formKey.currentState.save();

                          // Running the registration started event
                          BlocProvider.of<SignInBloc>(context).add(
                            SignInStarted(
                              email: _email,
                              password: _password,
                            ),
                          );

                          /// HACK Used to sync the current states
                          /// With the sign in button animations
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
                    ),
                  ),
                ],
              ),
            ),

            // # Sized Box for spacing
            SizedBox(height: Device.height(8.0)),

            // # Divider for Coolness
            CustomDivider(text: 'OR', enabled: _areThingsEnabled),

            // # Sized Box for spacing
            SizedBox(height: Device.height(8.0)),

            // # Sign Up Button
            SignUpButton(enabled: _areThingsEnabled),
          ],
        ),
      ),
    );
  }
}
