import 'package:fitness_app/data/models/user/user_model.dart';

class UserEntity {
  late String id;
  String? name;
  String? photo;
  String? email;

  UserEntity.fromUserModel(UserModel userModel) {
    id = userModel.user!.id!;
    name = userModel.user!.name;
    photo = userModel.user!.photo;
    email = userModel.user!.email;
  }
}
