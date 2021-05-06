import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'user_data_repository.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  late final UserModel? currentUser;
  late final UserDataRepository userDataRepository;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance {
    this.currentUser = _mapUserToUserModel(_firebaseAuth.currentUser);

    if (currentUser != null) {
      this.userDataRepository = UserDataRepository(currentUser!);
    }
  }

  Future<UserModel> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _mapUserCredentialToUserModel(
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    )!;
  }

  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _mapUserCredentialToUserModel(
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    )!;
  }

  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().distinct().map(_mapUserToUserModel);
  }

  Future<void> updateProfile({String? displayName, String? photoToURL}) {
    return _firebaseAuth.currentUser!.updateProfile(
      displayName: displayName,
      photoURL: photoToURL,
    );
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  // # Mappers
  UserModel? _mapUserCredentialToUserModel(UserCredential rawUserCredential) {
    return _mapUserToUserModel(rawUserCredential.user);
  }

  UserModel? _mapUserToUserModel(User? rawUser) {
    return (rawUser == null)
        ? null
        : UserModel(
            uid: rawUser.uid,
            email: rawUser.email,
            displayName: rawUser.displayName,
            isEmailVerified: rawUser.emailVerified,
          );
  }
}
