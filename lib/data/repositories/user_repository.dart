import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_data_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  late final DocumentReference _userDocument;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance {
    _userDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid);
  }

  UserModel? getUser() {
    return _mapUserToUserModel(_firebaseAuth.currentUser);
  }

  Stream<UserDataModel?> get userDataStream {
    return _userDocument
        .snapshots()
        .distinct()
        .map(_mapSnapshotToUserDataModel);
  }

  Future<UserDataModel?> getUserData() {
    return _userDocument.get().then(_mapSnapshotToUserDataModel);
  }

  Future<void> setUserData(UserDataModel userData) {
    return _userDocument.set(userData.toMap(), SetOptions(merge: true));
  }

  Future<void> updateUserData(UserDataModel userData) {
    return _userDocument.update(userData.toMap());
  }

  Future<void> deleteUserData() => _userDocument.delete();

  Future<void> updateUserProfile({String? displayName, String? photoToURL}) {
    return _firebaseAuth.currentUser!.updateProfile(
      displayName: displayName,
      photoURL: photoToURL,
    );
  }

  // ## Mappers
  // ### User
  UserModel? _mapUserToUserModel(User? rawUser) {
    return (rawUser == null)
        ? null
        : UserModel(
            uid: rawUser.uid,
            email: rawUser.email,
            displayName: rawUser.displayName,
          );
  }

  // ### User Data
  UserDataModel? _mapSnapshotToUserDataModel(DocumentSnapshot snapshot) {
    return (snapshot.data() == null)
        ? null
        : UserDataModel.fromMap(snapshot.data()!);
  }
}
