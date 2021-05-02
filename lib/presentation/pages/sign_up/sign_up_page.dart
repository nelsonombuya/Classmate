import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_up/sign_up_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../constants/route.dart' as route;
import '../../../constants/validator.dart';
import '../../common_widgets/custom_elevated_button.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(context),
      child: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordConfirmationValidator _passwordConfirmation =
      PasswordConfirmationValidator();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    SignUpBloc _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpValidation) {
          if (_formKey.currentState == null) {
            _signUpBloc.addError("Current Form State is Null ❗ ");
            throw Exception("Current Form State is Null ❗ ");
          }

          if (_formKey.currentState!.validate()) {
            setState(() => _showPassword = false);
            _signUpBloc.add(
              SignUpCredentialsValid(
                email: _emailController.text.trim(),
                password: _passwordController.text,
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
              ),
            );
          } else {
            _signUpBloc.add(SignUpCredentialsInvalid());
          }
        }

        if (state is SignUpSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            route.initPage,
            (route) => false,
          );
        }
      },
      child: FormView(
        title: "Sign Up",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          label: 'First Name',
                          controller: _firstNameController,
                          keyboardType: TextInputType.name,
                          validator: Validator.nameValidator,
                        ),
                      ),
                      SizedBox(width: _deviceQuery.safeWidth(4.0)),
                      Expanded(
                        child: CustomTextFormField(
                          label: 'Last Name',
                          controller: _lastNameController,
                          keyboardType: TextInputType.name,
                          validator: Validator.nameValidator,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Email Address',
                    controller: _emailController,
                    validator: Validator.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Password',
                    obscureText: !_showPassword,
                    controller: _passwordController,
                    validator: Validator.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () =>
                        setState(() => _showPassword = !_showPassword),
                    onChanged: (value) => setState(
                        () => _passwordConfirmation.initialPassword = value),
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Confirm Password',
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () =>
                        setState(() => _showPassword = !_showPassword),
                    validator: _passwordConfirmation.confirmPasswordValidator,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(8.0)),
                  Center(
                    child: CustomElevatedButton(
                      label: 'Sign Up',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _signUpBloc.add(SignUpRequested());
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
