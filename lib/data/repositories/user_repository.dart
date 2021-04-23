import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

/// # User Repository
/// Mostly has Firebase Code and General User Data
/// Has all the relevant functions used during Authentication
class UserRepository {
  // _ AUTH
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // # Parser
  UserModel _parseRawData(rawUser) {
    if (rawUser == null) return null;

    /// This is so as to use this function to parse data from all functions
    ///
    /// Since signUpWithEmail and signUpWithEmail return UserCredential Objects
    /// Which has the User object at UserCredential.user
    ///
    /// While the rest either return void or User Objects directly
    if (rawUser is UserCredential) rawUser = rawUser.user;

    return UserModel(
      uid: rawUser.uid,
      email: rawUser.email,
      displayName: rawUser.displayName,
      updateProfile: rawUser.updateProfile,
      isEmailVerified: rawUser.emailVerified,
    );
  }

  // # Streams
  Stream<UserModel> get authStateChanges {
    /// authStateChanges Returns a UserModel Object when the user is signed in
    /// And null when the user is not signed in
    /// Has been set to only return distinct values
    return _firebaseAuth.authStateChanges().distinct().map(_parseRawData);
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

  Future<void> updateProfile({String displayName, String photoToURL}) async {
    return await _firebaseAuth.currentUser
        .updateProfile(displayName: displayName, photoURL: photoToURL);
  }

  UserModel currentUser() => _parseRawData(_firebaseAuth.currentUser);

  bool isUserSignedIn() => this._firebaseAuth.currentUser != null;

  Future<void> signOut() async => await _firebaseAuth.signOut();

  // _ FIRESTORE
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  // # Streams
  Stream<QuerySnapshot> get userDataStream {
    return _usersCollection.snapshots().distinct();
  }

  // # Methods
  Future updateUserData(UserModel user, Map<String, dynamic> userData) async {
    return await _usersCollection.doc(user.uid).set(userData);
  }
}
