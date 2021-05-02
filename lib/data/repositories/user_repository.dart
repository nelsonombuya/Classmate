import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<List<UserModel>> get userDataStream {
    return _usersCollection
        .snapshots()
        .distinct()
        .map(_mapSnapshotToUserModelList);
  }

  List<UserModel> _mapSnapshotToUserModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel.fromMap(doc.data());
    }).toList();
  }

  Future updateUserData(AuthModel user, UserModel userData) async {
    return _usersCollection
        .doc(user.uid)
        .set(userData.toMap(), SetOptions(merge: true));
  }

  Future deleteUserData(AuthModel user) async {
    return _usersCollection.doc(user.uid).delete();
  }
}
