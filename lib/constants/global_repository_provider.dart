import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/authentication_repository.dart';

/// # Global Repository Provider
/// Used to provide the necessary repositories to the rest of the app
/// Currently contains:
///   * Authentication Repository
///     Contains current user authentication states
class GlobalRepositoryProvider extends StatelessWidget {
  const GlobalRepositoryProvider({
    Key? key,
    required Widget child,
    required AuthenticationRepository authenticationRepository,
  })   : _child = child,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  final Widget _child;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
      ],
      child: _child,
    );
  }
}
