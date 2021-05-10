import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/authentication_repository.dart';
import '../data/repositories/user_repository.dart';

/// # Global Repository Provider
/// Used to provide the necessary repositories to the rest of the app
/// Currently contains:
///   * Authentication Repository
///     Contains current user authentication states
///   * User Repository
///     Contains current user data according to the authentication states
class GlobalRepositoryProvider extends StatelessWidget {
  const GlobalRepositoryProvider({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.child,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: userRepository),
      ],
      child: child,
    );
  }
}
