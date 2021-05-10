import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants/device_query.dart';
import '../constants/route.dart' as route;
import '../constants/themes.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/user_repository.dart';
import 'global_bloc_provider.dart';
import 'global_repository_provider.dart';
import 'redirect_to_first_page.dart';

/// # Classmate
/// Contains:
///   * Global Repository Provider
///   * Global BLoC Provider
///   * Notification Listener
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
    return GlobalRepositoryProvider(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
      child: GlobalBLoCProvider(
        navigatorKey: _navigatorKey,
        userRepository: userRepository,
        authenticationRepository: authenticationRepository,
        child: MaterialApp(
          onGenerateRoute: route.controller,
          navigatorKey: _navigatorKey,
          builder: EasyLoading.init(),
          darkTheme: Themes.darkTheme,
          theme: Themes.lightTheme,
          title: 'Classmate',
          home: DeviceQuery(
            context,
            NotificationListener(
              child: RedirectToFirstPage(),
            ),
          ),
        ),
      ),
    );
  }
}
