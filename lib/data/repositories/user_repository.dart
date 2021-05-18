import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserModel _user;
  final DocumentReference _userDocument;

  UserRepository(UserModel user)
      : _user = user,
        _userDocument =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

  UserModel? getCurrentUser() => _user;

  Stream<UserData> get userDataStream {
    return _userDocument
        .snapshots()
        .distinct()
        .map(_mapDocumentSnapshotToUserData);
  }

  Future<UserData> getUserData() {
    return _userDocument.get().then(_mapDocumentSnapshotToUserData);
  }

  Future<void> setUserData(UserData userData) {
    return _userDocument.set(userData.toMap(), SetOptions(merge: true));
  }

  // TODO Delete User's Sub-Collections too
  Future<void> deleteUserData() => _userDocument.delete();

  UserData _mapDocumentSnapshotToUserData(DocumentSnapshot snapshot) {
    return (snapshot.data() == null)
        ? UserData()
        : UserData.fromMap(snapshot.data()!);
  }
}
