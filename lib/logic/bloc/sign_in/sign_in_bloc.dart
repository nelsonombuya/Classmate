import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/route.dart' as route;
import '../../../data/repositories/authentication_repository.dart';
import '../../cubit/navigation/navigation_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required NavigationCubit navigationCubit,
    required NotificationCubit notificationCubit,
    required AuthenticationRepository authenticationRepository,
  })   : _navigationCubit = navigationCubit,
        _notificationCubit = notificationCubit,
        _authenticationRepository = authenticationRepository,
        super(SignInInitial());

  final AuthenticationRepository _authenticationRepository;
  final NotificationCubit _notificationCubit;
  final NavigationCubit _navigationCubit;

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInRequested) {
      yield* _mapSignInRequestedToState(event);
    }
  }

  Stream<SignInState> _mapSignInRequestedToState(SignInRequested event) async* {
    try {
      _showSignInLoadingNotification();
      await _authenticationRepository.signIn(event.email, event.password);
      _showSignInSuccessNotification();
      _navigateToDashboard();
      yield SignInSuccess(_authenticationRepository.getCurrentUser()!.uid);
    } catch (e) {
      _showSignInUnsuccessfulNotification(e.toString());
      yield SignInFailure(e.toString());
      this.addError(e);
    }
  }

  // ### Notifications
  void _showSignInLoadingNotification() {
    return _notificationCubit.showAlert(
      'Signing In...',
      type: NotificationType.Loading,
    );
  }

  void _showSignInSuccessNotification() {
    return _notificationCubit.showAlert(
      "Signed In Successfully",
      type: NotificationType.Success,
    );
  }

  void _showSignInUnsuccessfulNotification(String errorMessage) {
    _notificationCubit.showAlert(
      "Error Signing In",
      type: NotificationType.Danger,
    );

    _notificationCubit.showSnackBar(
      errorMessage,
      title: "Error Signing In",
      type: NotificationType.Danger,
    );
  }

  // ### Navigation
  void _navigateToDashboard() {
    _navigationCubit.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      // Will automatically redirect to Dashboard Page
      // and maintain Global BLoC Providers, Repository Providers
      // Listeners and Builders in the tree.
      // ! DO NOT DELETE OR CHANGE
      route.root,
      (route) => false,
    );
  }
}
