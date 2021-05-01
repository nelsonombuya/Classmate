import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  UserModel? _parseUserToUserModel(User? rawUser) {
    return (rawUser == null)
        ? null
        : UserModel(
            uid: rawUser.uid,
            email: rawUser.email,
            displayName: rawUser.displayName,
            isEmailVerified: rawUser.emailVerified,
          );
  }

  UserModel _parseUserCredentialToUserModel(UserCredential rawUserCredential) {
    if (rawUserCredential.user == null) {
      // TODO Implement error handling ❗
      throw Exception("The user in UserCredential can't be null. ❗");
    }

    User rawUser = rawUserCredential.user!;
    return _parseUserToUserModel(rawUser)!;
  }

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    return _parseUserCredentialToUserModel(
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    return _parseUserCredentialToUserModel(
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth
        .authStateChanges()
        .distinct()
        .map(_parseUserToUserModel);
  }

  Future<void> updateProfile({String? displayName, String? photoToURL}) async {
    if (_firebaseAuth.currentUser == null) {
      // TODO Implement Error Handling ❗
      throw Exception("There is no user currently signed in ❗");
    }

    User currentUser = _firebaseAuth.currentUser!;
    return currentUser.updateProfile(
      displayName: displayName,
      photoURL: photoToURL,
    );
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  bool isUserSignedIn() {
    return _firebaseAuth.currentUser != null;
  }

  UserModel? getCurrentUser() {
    return _parseUserToUserModel(_firebaseAuth.currentUser);
  }

  Stream<QuerySnapshot> get userDataStream {
    return _usersCollection.snapshots().distinct();
  }

  Future updateUserData(UserModel user, Map<String, dynamic> userData) async {
    return _usersCollection
        .doc(user.uid)
        .set(userData, SetOptions(merge: true));
  }
}
