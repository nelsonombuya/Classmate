import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/authentication_repository.dart';
import '../logic/bloc/authentication/authentication_bloc.dart';
import '../logic/cubit/navigation/navigation_cubit.dart';
import '../logic/cubit/notification/notification_cubit.dart';

/// # Global BLoC Provider
/// Centralized widget that provides all of the necessary BLoCs to the rest of the app
/// Currently has:
///   * Authentication BLoC
///     For the user authentication states
///   * Notifications Cubit
///     For managing notifications globally
///   * Navigation Cubit
///     For allowing navigation from the BLoCs
class GlobalBLoCProvider extends StatelessWidget {
  const GlobalBLoCProvider({
    Key? key,
    required Widget child,
    required GlobalKey<NavigatorState> navigatorKey,
    required AuthenticationRepository authenticationRepository,
  })   : _child = child,
        _navigatorKey = navigatorKey,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  final Widget _child;
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authenticationRepository: _authenticationRepository,
          ),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(_navigatorKey),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit(
            navigationCubit: context.read<NavigationCubit>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
        ),
      ],
      child: _child,
    );
  }
}
