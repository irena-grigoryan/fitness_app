import 'package:fitness_app/data/data_sources/user_remote_data_source.dart';
import 'package:fitness_app/data/data_sources/user_local_data_source.dart';
import 'package:fitness_app/data/models/user/user_model.dart';
import 'package:fitness_app/domain/entities/user_entity.dart';
import 'package:fitness_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl(this.userRemoteDataSource, this.userLocalDataSource);

  Future getToken() => userLocalDataSource.getUserKeys();

  @override
  Future updateEmail(String email) => getToken()
      .then((idToken) =>
          userRemoteDataSource.updateEmail(idToken['idToken'], email))
      .then((value) =>
          userLocalDataSource.setUserKeys(value['idToken'], value['localId']));

  @override
  Future updateUserName(String name) => getToken().then(
      (value) => userRemoteDataSource.updateUserName(value['idToken'], name));

  @override
  Future updatePhoto(String photo) => getToken().then(
      (idToken) => userRemoteDataSource.updatePhoto(idToken['idToken'], photo));

  @override
  Future updatePassword(String password) => getToken()
      .then((idToken) =>
          userRemoteDataSource.updatePassword(idToken['idToken'], password))
      .then((value) =>
          userLocalDataSource.setUserKeys(value['idToken'], value['localId']));

  @override
  Future<UserEntity> getUserData() =>
      userLocalDataSource.getUserKeys().then((value) {
        final idToken = value['idToken'];
        return userRemoteDataSource
            .getUserData(idToken!)
            .then((value) => Future(() => UserModel.fromJson(value)))
            .then((userModel) => UserEntity.fromUserModel(userModel));
      });
}
