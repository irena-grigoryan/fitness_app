import 'package:fitness_app/presentation/constants/global_constants.dart';
import 'package:fitness_app/data/services/firebase_service.dart';
import 'package:fitness_app/data/data_sources/auth_remote_data_source.dart';
import 'package:fitness_app/data/data_sources/user_local_data_source.dart';
import 'package:fitness_app/data/data_sources/workouts_local_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final WorkoutsLocalDataSource workoutsLocalDataSource;
  final UserLocalDataSource userLocalDataSource;

  AuthRepositoryImpl(
      this.userLocalDataSource, this.authRemoteDataSource, this.workoutsLocalDataSource);

  @override
  Future registration(String email, String password) => authRemoteDataSource
      .registration(email, password)
      .then((value) => value != null ? saveUserKeys(value) : null);
      
  @override
  Future login(String email, String password) => authRemoteDataSource
      .login(email, password)
      .then((value) => value != null ? saveUserKeys(value) : null);


  @override
  Future resetPassword(String email) =>
      authRemoteDataSource.resetPassword(email);

  @override
  Future logout() => authRemoteDataSource.logout().then((value) {
        final currentUserEmail = GlobalConstants.currentUser.email;
        return {
          userLocalDataSource.clearData(),
          workoutsLocalDataSource
              .deleteData('${currentUserEmail}Workouts')
              .then((_) => FirebaseService.logOut()),
        };
      });

  @override
  Future saveKeys(String? token, String? localId) {
    return userLocalDataSource.setUserKeys(token, localId);
  }

  Future saveUserKeys(result) => saveKeys(result['idToken'], result['localId']);

  @override
  Future getToken() => userLocalDataSource.getUserKeys();

  @override
  Future deactivate() => getToken()
      .then((token) => token['idToken'] == null
          ? throw Exception('login again')
          : authRemoteDataSource.deactivate(token['idToken']))
      .then((value) => userLocalDataSource.clearData());
}
