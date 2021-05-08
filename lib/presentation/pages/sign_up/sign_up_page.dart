import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_up/sign_up_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../../cubit/navigation/navigation_cubit.dart';
import '../../../cubit/notification/notification_cubit.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../common_widgets/custom_elevated_button.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordConfirmationValidator _passwordConfirmation =
      PasswordConfirmationValidator();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);

    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        context.read<AuthenticationRepository>(),
        context.read<NotificationCubit>(),
        context.read<UserRepository>(),
        context.read<NavigationCubit>(),
      ),
      child: FormView(
        title: "Sign Up",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _deviceQuery.safeHeight(2.0),
            ),
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
                      SizedBox(
                        width: _deviceQuery.safeWidth(4.0),
                      ),
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
                  SizedBox(
                    height: _deviceQuery.safeHeight(3.0),
                  ),
                  CustomTextFormField(
                    label: 'Email Address',
                    controller: _emailController,
                    validator: Validator.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: _deviceQuery.safeHeight(3.0),
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    obscureText: !_showPassword,
                    controller: _passwordController,
                    validator: Validator.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () => setState(
                      () => _showPassword = !_showPassword,
                    ),
                    onChanged: (value) => setState(
                      () => _passwordConfirmation.initialPassword = value,
                    ),
                  ),
                  SizedBox(
                    height: _deviceQuery.safeHeight(3.0),
                  ),
                  CustomTextFormField(
                    label: 'Confirm Password',
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: _showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixIconAction: () => setState(
                      () => _showPassword = !_showPassword,
                    ),
                    validator: _passwordConfirmation.confirmPasswordValidator,
                  ),
                  SizedBox(
                    height: _deviceQuery.safeHeight(8.0),
                  ),
                  Center(
                    child: CustomElevatedButton(
                      label: 'Sign Up',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showPassword = false);
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                                SignUpRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                ),
                              );
                        }
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
