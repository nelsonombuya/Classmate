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
        .map(_mapDocumentSnapshotToUserDataModel);
  }

  Future<UserDataModel?> getUserData() {
    return _userDocument.get().then(_mapDocumentSnapshotToUserDataModel);
  }

  Future<void> setUserData(UserDataModel userData) {
    return _userDocument.set(userData.toMap(), SetOptions(merge: true));
  }

  Future<void> deleteUserData() => _userDocument.delete();

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

  UserDataModel? _mapDocumentSnapshotToUserDataModel(
      DocumentSnapshot snapshot) {
    return (snapshot.data() == null)
        ? null
        : UserDataModel.fromMap(snapshot.data()!);
  }
}
