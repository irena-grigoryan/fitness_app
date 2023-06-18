import 'package:fitness_app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future updateUserName(String name);
  Future updateEmail(String email);
  Future updatePhoto(String photo);
  Future updatePassword(String password);
  Future<UserEntity> getUserData();
}
