import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/route.dart' as route;
import '../../cubit/navigation/navigation_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';
import '../../data/models/user_data_model.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  final NotificationCubit _notificationCubit;
  final UserRepository _userRepository;
  final NavigationCubit _navigationCubit;

  SignUpBloc(
    this._authenticationRepository,
    this._notificationCubit,
    this._userRepository,
    this._navigationCubit,
  ) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpRequested) {
      yield* _mapSignUpRequestedToState(event);
    }
  }

  Stream<SignUpState> _mapSignUpRequestedToState(SignUpRequested event) async* {
    try {
      _showSignUpLoadingNotification();
      await _authenticationRepository.signUp(event.email, event.password);
      await _setNewUserNames(event.firstName, event.lastName);
      _showSignUpSuccessfulNotification();
      _navigateToDashboard();
      yield SignUpSuccess(_userRepository.getUser()!.uid);
    } catch (e) {
      _showSignUpUnsuccessfulNotification(e.toString());
      yield SignUpFailure(e.toString());
      this.addError(e);
    }
  }

  Future<void> _setNewUserNames(String firstName, String lastName) async {
    await _setDisplayName(firstName, lastName);
    await _setNamesInDatabase(firstName, lastName);
  }

  Future<void> _setDisplayName(String firstName, String lastName) async {
    String displayName = "${firstName[0]}. $lastName";
    await _userRepository.updateUserProfile(displayName: displayName);
  }

  Future<void> _setNamesInDatabase(String firstName, String lastName) async {
    UserDataModel userData = UserDataModel(
      firstName: firstName,
      lastName: lastName,
    );
    await _userRepository.setUserData(userData);
  }

  void _showSignUpLoadingNotification() {
    return _notificationCubit.showAlert(
      'Signing Up...',
      type: NotificationType.Loading,
    );
  }

  void _showSignUpSuccessfulNotification() {
    _notificationCubit.showAlert(
      "Signed Up Successfully",
      type: NotificationType.Success,
    );
  }

  void _showSignUpUnsuccessfulNotification(String errorMessage) {
    _notificationCubit.showAlert(
      "Error Signing Up",
      type: NotificationType.Danger,
    );
    _notificationCubit.showSnackBar(
      errorMessage,
      title: "Error Signing Up",
      type: NotificationType.Danger,
    );
  }

  void _navigateToDashboard() {
    _navigationCubit.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route.root,
      (route) => false,
    );
  }
}
