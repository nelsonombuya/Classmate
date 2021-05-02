import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_model.dart';
import '../models/user_data_model.dart';

class UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<List<UserDataModel>> get userDataStream {
    return _usersCollection
        .snapshots()
        .distinct()
        .map(_mapSnapshotToUserModelList);
  }

  List<UserDataModel> _mapSnapshotToUserModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserDataModel.fromMap(doc.data());
    }).toList();
  }

  Future updateUserData(AuthModel user, UserDataModel userData) async {
    return _usersCollection
        .doc(user.uid)
        .set(userData.toMap(), SetOptions(merge: true));
  }

  Future deleteUserData(AuthModel user) async {
    return _usersCollection.doc(user.uid).delete();
  }
}
