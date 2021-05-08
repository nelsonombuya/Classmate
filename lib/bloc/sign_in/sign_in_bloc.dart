import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/route.dart' as route;
import '../../cubit/navigation/navigation_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(
    this._authenticationRepository,
    this._notificationCubit,
    this._userRepository,
    this._navigationCubit,
  ) : super(SignInInitial());

  final AuthenticationRepository _authenticationRepository;
  final NotificationCubit _notificationCubit;
  final UserRepository _userRepository;
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
      yield SignInSuccess(_userRepository.getUser()!.uid);
      _navigateToDashboard();
    } catch (e) {
      this.addError(e);
      _showSignInUnsuccessfulNotification(e.toString());
      yield SignInFailure(e.toString());
    }
  }

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

  void _navigateToDashboard() {
    _navigationCubit.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route.root, // Will automatically redirect to Dashboard Page
      (route) => false,
    );
  }
}
