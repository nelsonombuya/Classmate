import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants/global_bloc_observer.dart';
import 'constants/global_bloc_provider.dart';
import 'constants/global_repository_provider.dart';
import 'constants/notification_cubit_listener.dart';
import 'constants/redirect_to_first_page.dart';
import 'constants/route.dart' as route;
import 'constants/themes.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  await Firebase.initializeApp();
  Bloc.observer = Watchtower();

  // TODO Restructure App for Landscape Orientation
  // TODO Restructure App for Web View

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    )),
  );
}

class App extends StatelessWidget {
  App({
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
