import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthModel> createUserWithEmailAndPassword(
      String email, String password) async {
    return _mapUserCredentialToUserModel(
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<AuthModel> signInWithEmailAndPassword(
      String email, String password) async {
    return _mapUserCredentialToUserModel(
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Stream<AuthModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().distinct().map(_mapUserToUserModel);
  }

  Future<void> updateProfile({String? displayName, String? photoToURL}) {
    if (_firebaseAuth.currentUser == null) {
      throw Exception("There is no user currently signed in ❗");
    }

    return _firebaseAuth.currentUser!.updateProfile(
      displayName: displayName,
      photoURL: photoToURL,
    );
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  bool isUserSignedIn() {
    return _firebaseAuth.currentUser != null;
  }

  AuthModel? getCurrentUser() {
    return _mapUserToUserModel(_firebaseAuth.currentUser);
  }

  AuthModel? _mapUserToUserModel(User? rawUser) {
    return (rawUser == null)
        ? null
        : AuthModel(
            uid: rawUser.uid,
            email: rawUser.email,
            displayName: rawUser.displayName,
            isEmailVerified: rawUser.emailVerified,
          );
  }

  AuthModel _mapUserCredentialToUserModel(UserCredential rawUserCredential) {
    if (rawUserCredential.user == null) {
      throw Exception("The user in UserCredential can't be null. ❗");
    }

    User rawUser = rawUserCredential.user!;
    return _mapUserToUserModel(rawUser)!;
  }
}
