import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirebaseRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  updateUserData(UserModel user, Map<String, dynamic> userData) {
    return _usersCollection.doc(user.uid).set(userData);
  }

  Future<UserModel> getUserData(UserModel user) async {
    // return _usersCollection.doc(user.uid).get()
  }
}
