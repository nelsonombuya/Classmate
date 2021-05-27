import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data_model.dart';
import '../models/user_model.dart';

class UserRepository {
  UserRepository(UserModel user)
      : _user = user,
        _userDocument =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

  final UserModel _user;
  final DocumentReference _userDocument;

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

  UserData _mapDocumentSnapshotToUserData(DocumentSnapshot snapshot) {
    return UserData.fromMap(snapshot.data()!);
  }
}
