import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants/route.dart' as route;
import '../constants/themes.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/user_repository.dart';
import 'global_bloc_provider.dart';
import 'global_repository_provider.dart';
import 'notification_cubit_listener.dart';
import 'redirect_to_first_page.dart';

/// # Classmate
/// Contains:
///   * Global Repository Provider
///   * Global BLoC Provider
///   * Notification Listener
///   * First Page Redirection Widget
class Classmate extends StatelessWidget {
  Classmate({
    Key? key,
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })   : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GlobalRepositoryProvider(
      userRepository: _userRepository,
      authenticationRepository: _authenticationRepository,
      child: GlobalBLoCProvider(
        navigatorKey: _navigatorKey,
        userRepository: _userRepository,
        authenticationRepository: _authenticationRepository,
        child: MaterialApp(
          onGenerateRoute: route.controller,
          navigatorKey: _navigatorKey,
          builder: EasyLoading.init(),
          darkTheme: Themes.darkTheme,
          theme: Themes.lightTheme,
          title: 'Classmate',
          home: NotificationCubitListener(
            child: RedirectToFirstPage(),
          ),
        ),
      ),
    );
  }
}
