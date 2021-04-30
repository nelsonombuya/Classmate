import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/notification/notification_bloc.dart';
import '../constants/device_query.dart';
import 'common_widgets/custom_dialog.dart';
import 'common_widgets/custom_snack_bar.dart';
import 'pages/home/home.dart';
import 'pages/splash/splash_page.dart';
import 'pages/welcome/welcome_page.dart';

/// # Init
/// * Holds the Notifications Listener:
///   - Shows either a snack bar or a dialog box upon request
///
/// * Holds the Auth Builder:
///   - Sends the user directly to the dashboard if they're authenticated
///   - Kicks them back to the Welcome Page if they're not signed in
///
/// * Holds the Device Query Inherited Widget
///   - Used in the scaling of widgets across the app
///   - Used to provide MediaQuery data
class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is ShowSnackBar) {
          CustomSnackBar(
            context,
            message: state.message,
            type: state.notificationType,
          );
        }
        if (state is ShowDialogBox) {
          CustomDialog(
            context,
            title: state.title,
            description: state.message,
            type: state.notificationType,
            descriptionIcon: state.descriptionIcon,
            positiveActionIcon: state.positiveActionIcon,
            positiveActionLabel: state.positiveActionLabel,
            positiveActionOnPressed: state.positiveActionOnPressed,
            negativeActionLabel: state.negativeActionLabel,
            negativeActionOnPressed: state.negativeActionOnPressed,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Unauthenticated) return WelcomePage();

          if (state is Authenticated) return HomePage();

          if (state is AuthenticationError)
            return SplashPage(message: state.errorMessage);

          return SplashPage();
        },
      ),
    );
  }
}
