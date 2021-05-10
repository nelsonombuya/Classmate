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
    required Widget child,
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })   : _child = child,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  final Widget _child;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: _child,
    );
  }
}
