import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DatabaseRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(UserModel user, Map<String, dynamic> userData) async {
    return await _usersCollection.doc(user.uid).set(userData);
  }

  Stream<QuerySnapshot> get userDataStream {
    return _usersCollection.snapshots().distinct();
  }
}
