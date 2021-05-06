import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../models/user_data_model.dart';

class UserDataRepository {
  final DocumentReference _userDocument;

  UserDataRepository(UserModel user)
      : _userDocument =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

  Future<UserDataModel?> getUserData() {
    return _userDocument.get().then(_mapSnapshotToUserModelList);
  }

  Stream<UserDataModel?> get userDataStream {
    return _userDocument
        .snapshots()
        .distinct()
        .map(_mapSnapshotToUserModelList);
  }

  Future setUserData(UserDataModel userData) {
    return _userDocument.set(userData.toMap(), SetOptions(merge: true));
  }

  Future updateUserData(UserDataModel userData) {
    return _userDocument.update(userData.toMap());
  }

  Future deleteUserData() => _userDocument.delete();

  // # Mappers
  UserDataModel? _mapSnapshotToUserModelList(DocumentSnapshot snapshot) {
    return (snapshot.data() == null)
        ? null
        : UserDataModel.fromMap(snapshot.data()!);
  }
}
