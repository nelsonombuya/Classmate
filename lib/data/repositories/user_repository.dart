import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      throw Exception(e.toString());
    }
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
