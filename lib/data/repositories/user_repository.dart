import 'package:classmate/data/repositories/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data_model.dart';
import '../models/user_model.dart';

class UserRepository {
  late final DocumentReference _userDocument;
  final AuthenticationRepository _authenticationRepository;

  UserRepository(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        _userDocument = FirebaseFirestore.instance
            .collection('users')
            .doc(authenticationRepository.getCurrentUser()?.uid);

  UserModel? getCurrentUser() => _authenticationRepository.getCurrentUser();

  Stream<UserDataModel?> get userDataStream {
    return _userDocument
        .snapshots()
        .distinct()
        .map(_mapDocumentSnapshotToUserDataModel);
  }

  Future<UserDataModel?> getCurrentUserData() {
    return _userDocument.get().then(_mapDocumentSnapshotToUserDataModel);
  }

  Future<void> setUserData(UserDataModel userData) {
    return _userDocument.set(userData.toMap(), SetOptions(merge: true));
  }

  Future<void> deleteUserData() => _userDocument.delete();

  UserDataModel? _mapDocumentSnapshotToUserDataModel(
      DocumentSnapshot snapshot) {
    return (snapshot.data() == null)
        ? null
        : UserDataModel.fromMap(snapshot.data()!);
  }
}
