import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static Future<User?> login(String email, String password) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = result.user;
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> logOut() async {
    await auth.signOut();
  }
}
