import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../logic/bloc/sign_in/sign_in_bloc.dart';
import '../../../logic/cubit/navigation/navigation_cubit.dart';
import '../../../logic/cubit/notification/notification_cubit.dart';
import '../../common_widgets/custom_elevated_button.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';
import 'widgets/divider_with_text.dart';
import 'widgets/forgot_password_button.dart';
import 'widgets/sign_up_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        navigationCubit: context.read<NavigationCubit>(),
        notificationCubit: context.read<NotificationCubit>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: _SignInPageView(),
    );
  }
}

class _SignInPageView extends StatefulWidget {
  @override
  _SignInPageViewState createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<_SignInPageView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery(context);
    final SignInBloc _bloc = context.read<SignInBloc>();

    return FormView(
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
                  _bloc.add(
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
          DividerWithText('OR'),
          SizedBox(height: _deviceQuery.safeHeight(6.0)),
          SignUpButton(),
        ],
      ),
    );
  }
}
