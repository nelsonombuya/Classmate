import 'dart:async';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_up/sign_up_bloc.dart';
import '../../../constants/device.dart';
import '../../../constants/validators.dart';
import '../../widgets/custom_form_view_widget.dart';
import '../../widgets/custom_loading_elevatedButton_widget.dart';
import '../../widgets/custom_textFormField_widget.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _firstName, _lastName, _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PasswordConfirmationValidator _passwordConfirmation =
      PasswordConfirmationValidator();

  bool _proceed;
  bool _showPassword = false;
  bool _isInputEnabled = true;

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    SignUpBloc _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    Future<bool> _onSignUpButtonPressed() async {
      _signUpBloc.add(SignUpRequested());

      /// HACK Used to sync the current states
      /// With the sign up button animations
      while (_proceed == null) await Future.delayed(Duration(seconds: 3));
      return _proceed;
    }

    void _onSignUpButtonAnimationEnd() {
      if (_proceed == true) {
        setState(() => _proceed = null);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        setState(() {
          _proceed = null;
          _isInputEnabled = true;
        });
      }
    }

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpValidation) {
          if (_formKey.currentState.validate()) {
            setState(() {
              _showPassword = false;
              _isInputEnabled = false;
            });

            _formKey.currentState.save();

            _signUpBloc.add(
              SignUpStarted(
                email: _email.trim(),
                password: _password,
                firstName: _firstName.trim(),
                lastName: _lastName.trim(),
              ),
            );
          } else {
            _signUpBloc.add(SignUpValidationFailed());
            setState(() {
              _isInputEnabled = true;
              _proceed = false;
            });
          }
        }

        if (state is SignUpSuccess) setState(() => _proceed = true);

        if (state is SignUpFailure) setState(() => _proceed = false);
      },
      child: FormView(
        title: "Sign Up",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Device.height(2.0)),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          label: 'First Name',
                          enabled: _isInputEnabled,
                          keyboardType: TextInputType.name,
                          validator: Validator.nameValidator,
                          onSaved: (value) => _firstName = value,
                        ),
                      ),
                      SizedBox(width: Device.width(4.0)),
                      Expanded(
                          child: CustomTextFormField(
                        label: 'Last Name',
                        enabled: _isInputEnabled,
                        keyboardType: TextInputType.name,
                        validator: Validator.nameValidator,
                        onSaved: (value) => _lastName = value,
                      )),
                    ],
                  ),
                  SizedBox(height: Device.height(3.0)),
                  CustomTextFormField(
                    label: 'Email Address',
                    enabled: _isInputEnabled,
                    onSaved: (value) => _email = value,
                    validator: Validator.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: Device.height(3.0)),
                  CustomTextFormField(
                    label: 'Password',
                    enabled: _isInputEnabled,
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
                  SizedBox(height: Device.height(3.0)),
                  CustomTextFormField(
                    label: 'Confirm Password',
                    enabled: _isInputEnabled,
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () =>
                        setState(() => _showPassword = !_showPassword),
                    validator: _passwordConfirmation.confirmPasswordValidator,
                  ),
                  SizedBox(height: Device.height(8.0)),
                  Center(
                    child: CustomLoadingElevatedButton(
                      onPressed: _onSignUpButtonPressed,
                      onEnd: _onSignUpButtonAnimationEnd,
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.button,
                      ),
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
