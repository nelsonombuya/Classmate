import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

/// # User Repository
/// Mostly has Firebase Code and General User Data
/// Has all the relevant functions used during Authentication
class UserRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // # Parser
  UserModel _parseRawData(rawUser) {
    if (rawUser == null) return null;

    if (rawUser is UserCredential) rawUser = rawUser.user;

    return UserModel(
      initials: "N/A",
      uid: rawUser.uid,
      email: rawUser.email,
      displayName: rawUser.displayName,
      isEmailVerified: rawUser.emailVerified,
    );
  }

  // # Streams
  Stream<UserModel> get authStateChanges async* {
    /// * authStateChanges Returns a UserModel Object when the user is signed in
    /// * And null when the user is not signed in
    await for (var rawUser in _firebaseAuth.authStateChanges())
      yield _parseRawData(rawUser);
  }

  // # Methods
  Future<UserModel> signUpWithEmail(String email, String password) async {
    return _parseRawData(
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<UserModel> signInWithEmail(String email, String password) async {
    return _parseRawData(
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();

  UserModel currentUser() => _parseRawData(_firebaseAuth.currentUser);
}
