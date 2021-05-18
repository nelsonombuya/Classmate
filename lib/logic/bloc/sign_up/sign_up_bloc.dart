import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/route.dart' as route;
import '../../../data/models/user_data_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../cubit/navigation/navigation_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required NavigationCubit navigationCubit,
    required NotificationCubit notificationCubit,
    required AuthenticationRepository authenticationRepository,
  })   : _navigationCubit = navigationCubit,
        _notificationCubit = notificationCubit,
        _authenticationRepository = authenticationRepository,
        super(SignUpInitial());

  final NavigationCubit _navigationCubit;
  final NotificationCubit _notificationCubit;
  final AuthenticationRepository _authenticationRepository;

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
      await _setNewUsersData(
        event.firstName,
        event.lastName,
        _authenticationRepository,
      );
      _showSignUpSuccessfulNotification();
      _navigateToDashboard();
      yield SignUpSuccess(_authenticationRepository.getCurrentUser()!.uid);
    } catch (e) {
      _showSignUpUnsuccessfulNotification(e.toString());
      yield SignUpFailure(e.toString());
      this.addError(e);
    }
  }

  Future<void> _setNewUsersData(
    String firstName,
    String lastName,
    AuthenticationRepository authenticationRepository,
  ) async {
    await _setDisplayName(
      firstName,
      lastName,
      authenticationRepository,
    );
    return await _setUserDataInDatabase(
      firstName,
      lastName,
      authenticationRepository,
    );
  }

  Future<void> _setDisplayName(
    String firstName,
    String lastName,
    AuthenticationRepository authenticationRepository,
  ) async {
    String displayName = "${firstName[0]}. $lastName";
    return await authenticationRepository.updateUserProfile(
        displayName: displayName);
  }

  Future<void> _setUserDataInDatabase(
    String firstName,
    String lastName,
    AuthenticationRepository authenticationRepository,
  ) async {
    UserData newUserData = UserData(
      firstName: firstName,
      lastName: lastName,
      privilege: 'user',
    );
    UserModel newUser = authenticationRepository.getCurrentUser()!;
    return await UserRepository(newUser).setUserData(newUserData);
  }

  // ### Notifications
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
