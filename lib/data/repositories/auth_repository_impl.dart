import 'package:fitness_app/core/constants/global_constants.dart';
import 'package:fitness_app/data/data_sources/auth_remote_data_source.dart';
import 'package:fitness_app/data/data_sources/user_local_data_source.dart';
import 'package:fitness_app/data/data_sources/workouts_local_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final WorkoutsLocalDataSource workoutsLocalDataSource;
  final UserLocalDataSource local;

  AuthRepositoryImpl(
      this.local, this.authRemoteDataSource, this.workoutsLocalDataSource);

  @override
  Future login(String email, String password) => authRemoteDataSource
      .login(email, password)
      .then((value) => value != null ? saveUserKeys(value) : null);

  @override
  Future registration(String email, String password) => authRemoteDataSource
      .registration(email, password)
      .then((value) => value != null ? saveUserKeys(value) : null);

  @override
  Future createUser(String email, String name, String photoUrl) =>
      local.getUserKeys().then((value) {
        // final idToken = value['idToken'];
        // final localId = value['localId'];
        return authRemoteDataSource
            .createUser(
                value['localId']!, email, name, photoUrl, value['idToken']!)
            .then((id) => local.setResponseId(id));
        // .then((userId) => saveUserId(userId));
      });

  @override
  Future resetPassword(String email) =>
      authRemoteDataSource.resetPassword(email);

  @override
  Future logout() => authRemoteDataSource.logout().then((value) {
        final currentUserEmail = GlobalConstants.currentUser.email;
        return {
          local.clearData(),
          workoutsLocalDataSource.deleteData('${currentUserEmail}Workouts')
          // .then((_) => AuthService.logOut()),
        };
      });

  @override
  Future saveKeys(String? token, String? localId) {
    return local.setUserKeys(token, localId);
  }

  Future saveUserKeys(result) => saveKeys(result['idToken'], result['localId']);

  @override
  Future getToken() => local.getUserKeys();

  @override
  Future deactivate() => getToken()
      .then((token) => token['idToken'] == null
          ? throw Exception('login again')
          : authRemoteDataSource.deactivate(token['idToken']))
      .then((value) => local.clearData());
}
