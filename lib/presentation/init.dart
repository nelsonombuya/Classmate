import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/notifications/notifications_bloc.dart';
import 'pages/home/home.dart';
import 'pages/splash/splash_page.dart';
import 'pages/welcome/welcome_page.dart';
import 'widgets/dialog_widget.dart';

/// # Init
/// Does all the necessary initializations needed when the app starts
class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state is ShowSnackBar) {}
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

          if (state is Authenticated) return Home();

          if (state is AuthenticationError)
            return SplashPage(error: state.message);

          // * Return the splash page in the meantime
          return SplashPage();
        },
      ),
    );
  }
}
