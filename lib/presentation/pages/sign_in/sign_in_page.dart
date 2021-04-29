import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sign_in/sign_in_bloc.dart';
import '../../../constants/device_query.dart';
import '../../../constants/validator.dart';
import '../../common_widgets/custom_textFormField.dart';
import '../../common_widgets/form_view.dart';
import 'widgets/divider_with_word_at_center.dart';
import 'widgets/sign_up_button.dart';

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
  late final DeviceQuery _deviceQuery;
  late final SignInBloc _signInBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceQuery = DeviceQuery.of(context);
    _signInBloc = BlocProvider.of<SignInBloc>(context);

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) async {},
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
                    validator: Validator.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: _deviceQuery.safeHeight(3.0)),
                  CustomTextFormField(
                    label: 'Password',
                    validator: Validator.passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: _deviceQuery.safeHeight(1.0)),
            // ForgotPasswordWidget(enabled: _isInputEnabled),
            SizedBox(height: _deviceQuery.safeHeight(6.0)),
            Center(
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.button,
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
