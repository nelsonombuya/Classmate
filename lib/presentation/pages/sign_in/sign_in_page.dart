import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_in/sign_in_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../cubit/navigation/navigation_cubit.dart';
import '../../../cubit/notification/notification_cubit.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../common_widgets/custom_elevated_button.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';
import 'widgets/divider_with_word_at_center.dart';
import 'widgets/forgot_password_button.dart';
import 'widgets/sign_up_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInBlocViewState createState() => _SignInBlocViewState();
}

class _SignInBlocViewState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        context.read<AuthenticationRepository>(),
        context.read<NotificationCubit>(),
        context.read<UserRepository>(),
        context.read<NavigationCubit>(),
      ),
      child: FormView(
        title: "Sign In",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _deviceQuery.safeHeight(2.0)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'E-Mail Address',
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
                    suffixIconAction: () =>
                        setState(() => _showPassword = !_showPassword),
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ],
              ),
            ),
            SizedBox(height: _deviceQuery.safeHeight(1.0)),
            ForgotPasswordButton(),
            SizedBox(height: _deviceQuery.safeHeight(6.0)),
            Center(
              child: CustomElevatedButton(
                label: 'Sign In',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  setState(() => _showPassword = false);
                  if (_formKey.currentState!.validate()) {
                    context.read<SignInBloc>().add(
                          SignInRequested(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          ),
                        );
                  }
                },
              ),
            ),
            SizedBox(height: _deviceQuery.safeHeight(6.0)),
            DividerWithWordAtCenter(text: 'OR'),
            SizedBox(height: _deviceQuery.safeHeight(6.0)),
            SignUpButton(),
          ],
        ),
      ),
    );
  }
}
