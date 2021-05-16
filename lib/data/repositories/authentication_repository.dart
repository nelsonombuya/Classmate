import 'dart:async';

import 'package:classmate/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _controller = StreamController<AuthenticationStatus>() {
    _subscription = _firebaseAuth
        .authStateChanges()
        .distinct()
        .asBroadcastStream()
        .listen((event) {
      event == null
          ? _controller.add(AuthenticationStatus.unauthenticated)
          : _controller.add(AuthenticationStatus.authenticated);
    });
  }

  final FirebaseAuth _firebaseAuth;
  late final StreamSubscription _subscription;
  final StreamController<AuthenticationStatus> _controller;

  Stream<AuthenticationStatus> get authenticationStatusStream async* {
    yield* _controller.stream.asBroadcastStream();
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _controller.add(AuthenticationStatus.authenticated);
  }

  void signOut() {
    _firebaseAuth.signOut();
    return _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
    _subscription.cancel();
  }

  UserModel? getCurrentUser() => _mapUserToUserModel(_firebaseAuth.currentUser);

  void deleteAccount() => _firebaseAuth.currentUser?.delete();

  Future<void> updateUserProfile({String? displayName, String? photoURL}) {
    return _firebaseAuth.currentUser!.updateProfile(
      displayName: displayName,
      photoURL: photoURL,
    );
  }

  UserModel? _mapUserToUserModel(User? rawUser) {
    return (rawUser == null)
        ? null
        : UserModel(
            uid: rawUser.uid,
            email: rawUser.email,
            displayName: rawUser.displayName,
          );
  }
}
