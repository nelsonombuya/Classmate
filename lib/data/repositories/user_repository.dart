import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  UserModel _parseUserToUserModel(User rawUser) {
    return (rawUser == null)
        ? null
        : UserModel(
            uid: rawUser.uid,
            email: rawUser.email,
            displayName: rawUser.displayName,
            updateProfile: rawUser.updateProfile,
            isEmailVerified: rawUser.emailVerified,
          );
  }

  UserModel _parseUserCredentialToUserModel(UserCredential rawUserCredential) {
    return (rawUserCredential == null)
        ? null
        : UserModel(
            uid: rawUserCredential.user.uid,
            email: rawUserCredential.user.email,
            displayName: rawUserCredential.user.displayName,
            updateProfile: rawUserCredential.user.updateProfile,
            isEmailVerified: rawUserCredential.user.emailVerified,
          );
  }

  Stream<UserModel> get authStateChanges {
    return _firebaseAuth
        .authStateChanges()
        .distinct()
        .map(_parseUserToUserModel);
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

  Future<void> updateProfile({String displayName, String photoToURL}) async {
    return await _firebaseAuth.currentUser.updateProfile(
      displayName: displayName,
      photoURL: photoToURL,
    );
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();

  bool isUserSignedIn() => this._firebaseAuth.currentUser != null;

  UserModel currentUser() => _parseUserToUserModel(_firebaseAuth.currentUser);

  Stream<QuerySnapshot> get userDataStream {
    return _usersCollection.snapshots().distinct();
  }

  Future updateUserData(UserModel user, Map<String, dynamic> userData) async {
    return await _usersCollection
        .doc(user.uid)
        .set(userData, SetOptions(merge: true));
  }
}
