// # Dart Imports
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:classmate/presentation/pages/sign_in/forgot_password_widget.dart';
import 'package:classmate/presentation/pages/sign_in/sign_up_button_widget.dart';
import 'package:classmate/presentation/widgets/custom_textFormField_widget.dart';
import 'package:classmate/presentation/pages/sign_in/custom_divider_widget.dart';
import 'package:classmate/presentation/widgets/custom_form_view_widget.dart';
import 'package:classmate/presentation/widgets/custom_header_widget.dart';
import 'package:classmate/bloc/login/login_bloc.dart';
import 'package:classmate/constants/validators.dart';
import 'package:classmate/constants/device.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/Material.dart';

// # Sign In Page
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _email, _password;

  // * Used to disable Fields and Buttons during sign In
  bool _areThingsEnabled = true;
  bool _showPassword = false;
  bool _proceed;

  // * Form Key for Form Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    Device().init(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) setState(() => _proceed = true);
        if (state is LoginFailure) {
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
                            _loginBloc.add(
                              LoginStarted(
                                email: _email,
                                password: _password,
                              ),
                            );

                            /// HACK Used to sync the current states
                            /// With the sign in button animations
                            while (_proceed == null)
                              await Future.delayed(Duration(seconds: 3));

                            bool result = _proceed;
                            setState(() => _proceed = null);

                            return result;
                          }
                        },
                        onEnd: () => setState(() => _areThingsEnabled = true)),
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
        ),
      ),
    );
  }
}
