import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/extensions/app_exceptions.dart';
import 'package:fitness_app/core/services/auth_service.dart';

class UserService {
  static final FirebaseAuth firebase = FirebaseAuth.instance;

  static Future<bool> updatePhoto(String photoUrl) async {
    try {
      await firebase.currentUser?.updatePhotoURL(photoUrl);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateUserData(
      {required String name, required String email}) async {
    try {
      await firebase.currentUser?.updateDisplayName(name);
      await firebase.currentUser?.updateEmail(email);
      return true;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<bool> updatePassword({required String newPass}) async {
    try {
      await firebase.currentUser?.updatePassword(newPass);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }
}
