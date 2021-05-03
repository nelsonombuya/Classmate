import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_model.dart';
import '../models/user_data_model.dart';

class UserRepository {
  final DocumentReference _userDocument;

  UserRepository(AuthModel user)
      : _userDocument =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

  Stream<UserDataModel?> get userDataStream {
    return _userDocument
        .snapshots()
        .distinct()
        .map(_mapSnapshotToUserModelList);
  }

  UserDataModel? _mapSnapshotToUserModelList(DocumentSnapshot snapshot) {
    return (snapshot.data() == null)
        ? null
        : UserDataModel.fromMap(snapshot.data()!);
  }

  Future updateUserData(UserDataModel userData) async {
    return _userDocument.set(
      userData.toMap(),
      SetOptions(merge: true),
    );
  }

  Future deleteUserData() async {
    return _userDocument.delete();
  }
}
