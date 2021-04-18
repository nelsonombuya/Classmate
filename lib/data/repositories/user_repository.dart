import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> createUser(String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User> signIn(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<User> getCurrentUser() async => _auth.currentUser;

  Future<bool> isUserSignedIn() async => _auth.currentUser != null;
}
