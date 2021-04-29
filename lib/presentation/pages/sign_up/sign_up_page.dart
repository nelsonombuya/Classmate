import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_up/sign_up_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordConfirmationValidator _passwordConfirmation =
      PasswordConfirmationValidator();

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    SignUpBloc _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {},
      child: FormView(
        title: "Sign Up",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
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
                          keyboardType: TextInputType.name,
                          validator: Validator.nameValidator,
                        ),
                      ),
                      SizedBox(width: _deviceQuery.safeWidth(4.0)),
                      Expanded(
                          child: CustomTextFormField(
                        label: 'Last Name',
                        keyboardType: TextInputType.name,
                        validator: Validator.nameValidator,
                      )),
                    ],
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Email Address',
                    validator: Validator.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Password',
                    validator: Validator.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    validator: _passwordConfirmation.confirmPasswordValidator,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(8.0)),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.button,
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
