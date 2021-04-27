import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_in/sign_in_bloc.dart';
import '../../../constants/device.dart';
import '../../../constants/validators.dart';
import '../../widgets/custom_form_view_widget.dart';
import '../../widgets/custom_loading_elevatedButton_widget.dart';
import '../../widgets/custom_textFormField_widget.dart';
import 'custom_divider_widget.dart';
import 'forgot_password_widget.dart';
import 'sign_up_button_widget.dart';

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
  _SignInBlocViewState createState() => _SignInBlocViewState();
}

class _SignInBlocViewState extends State<SignInView> {
  String _email, _password;

  bool _isInputEnabled = true;
  bool _showPassword = false;
  bool _proceed;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    SignInBloc _signInBloc = BlocProvider.of<SignInBloc>(context);

    Future<bool> _onSignInButtonPressed() async {
      _signInBloc.add(SignInRequested());

      /// HACK Used to sync the current states
      /// With the sign in button animations
      while (_proceed == null) await Future.delayed(Duration(seconds: 3));
      return _proceed;
    }

    void _onSignInButtonAnimationEnd() {
      if (_proceed == true) {
        setState(() => _proceed = null);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        setState(() => _proceed = null);
      }
    }

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) async {
        if (state is SignInValidation) {
          if (_formKey.currentState.validate()) {
            setState(() {
              _showPassword = false;
              _isInputEnabled = false;
            });

            _formKey.currentState.save();

            _signInBloc.add(
              SignInStarted(
                email: _email.trim(),
                password: _password,
              ),
            );
          } else {
            _signInBloc.add(SignInValidationFailed());
            setState(() {
              _isInputEnabled = true;
              _proceed = false;
            });
          }
        }

        if (state is SignInSuccess) setState(() => _proceed = true);

        if (state is SignInFailure) setState(() => _proceed = false);
      },
      child: FormView(
        title: "Sign In",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Device.height(2.0)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'E-Mail Address',
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
                  ),
                ],
              ),
            ),
            SizedBox(height: Device.height(1.0)),
            ForgotPasswordWidget(enabled: _isInputEnabled),
            SizedBox(height: Device.height(6.0)),
            Center(
              child: CustomLoadingElevatedButton(
                onPressed: _onSignInButtonPressed,
                onEnd: _onSignInButtonAnimationEnd,
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            SizedBox(height: Device.height(6.0)),
            CustomDivider(text: 'OR', enabled: _isInputEnabled),
            SizedBox(height: Device.height(6.0)),
            SignUpButton(enabled: _isInputEnabled),
          ],
        ),
      ),
    );
  }
}
