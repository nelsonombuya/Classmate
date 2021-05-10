import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication/authentication_bloc.dart';
import '../cubit/navigation/navigation_cubit.dart';
import '../cubit/notification/notification_cubit.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/user_repository.dart';

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
    required this.child,
    required this.navigatorKey,
    required this.userRepository,
    required this.authenticationRepository,
  }) : super(key: key);

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(navigatorKey),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
            authenticationRepository: authenticationRepository,
          ),
        ),
      ],
      child: DependentBLoCProviders(child),
    );
  }
}

class DependentBLoCProviders extends StatelessWidget {
  const DependentBLoCProviders(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit(
            navigationCubit: context.read<NavigationCubit>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
