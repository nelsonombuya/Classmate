import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../bloc/auth/auth_bloc.dart';
import '../constants/device_query.dart';
import '../constants/route.dart' as route;
import '../constants/themes.dart';
import '../cubit/notification/notification_cubit.dart';
import 'common_widgets/custom_alerts.dart';
import 'common_widgets/custom_dialog.dart';
import 'common_widgets/custom_snack_bar.dart';
import 'pages/home/home.dart';
import 'pages/splash/splash_page.dart';
import 'pages/welcome/welcome_page.dart';

/// # Classmate
/// Contains:
///   * Auth BLoC
///     For the user authentication states
///   * Notifications Cubit
///     For displaying global notifications
///   * Device Query
///     Used to scale widgets consistently among devices
///     Also used to provide MediaQuery Data
class Classmate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCheckStarted()),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: route.controller,
        builder: EasyLoading.init(),
        darkTheme: Themes.darkTheme,
        theme: Themes.lightTheme,
        title: 'Classmate',
        home: DeviceQuery(
          context,
          BlocListener<NotificationCubit, NotificationState>(
            listener: (context, state) {
              if (state is ShowAlert) {
                CustomAlert(
                  state.message,
                  notificationType: state.notificationType,
                );
              }

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

                if (state is AuthenticationError) {
                  return SplashPage(message: state.errorMessage);
                }

                return SplashPage();
              },
            ),
          ),
        ),
      ),
    );
  }
}
