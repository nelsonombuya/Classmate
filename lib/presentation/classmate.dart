import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../bloc/authentication/authentication_bloc.dart';
import '../constants/device_query.dart';
import '../constants/route.dart' as route;
import '../constants/themes.dart';
import '../cubit/navigation/navigation_cubit.dart';
import '../cubit/notification/notification_cubit.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/user_repository.dart';
import 'common_widgets/custom_alerts.dart';
import 'common_widgets/custom_dialog.dart';
import 'common_widgets/custom_snack_bar.dart';
import 'pages/home/home.dart';
import 'pages/splash/splash_page.dart';
import 'pages/welcome/welcome_page.dart';

/// # Classmate
/// Contains:
///   * Authentication BLoC
///     For the user authentication states
///   * Notifications Cubit
///     For managing notifications globally
///   * Device Query
///     Used to scale widgets consistently among devices
///     Also used to provide MediaQuery Data
class Classmate extends StatelessWidget {
  Classmate({
    Key? key,
    required this.userRepository,
    required this.authenticationRepository,
  }) : super(key: key);

  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(_navigatorKey),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              userRepository: userRepository,
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<NotificationCubit>(
            create: (context) => NotificationCubit(),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: route.controller,
          navigatorKey: _navigatorKey,
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
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      return HomePage();
                    case AuthenticationStatus.unauthenticated:
                      return WelcomePage();
                    default:
                      return SplashPage();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
