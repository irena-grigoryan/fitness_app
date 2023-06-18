import 'dart:convert';
import 'http_manager.dart';

abstract class AuthRemoteDataSource {
  Future login(String email, String password);
  Future registration(String email, String password);
  Future createUser(String localId, String email, String name, String photoUrl,
      String idToken);
  Future resetPassword(String email);
  Future logout();
  Future deactivate(String idToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  HttpManager httpManager;
  Object? response;
  AuthRemoteDataSourceImpl(this.httpManager);

  @override
  Future login(String email, String password) async {
    final map = <String, Object>{};
    map['email'] = email;
    map['password'] = password;
    map['returnSecureToken'] = true;
    return httpManager.post('accounts:signInWithPassword', json.encode(map));
  }

  @override
  Future registration(String email, String password) {
    final map = <String, Object>{};
    map['email'] = email;
    map['password'] = password;
    map['returnSecureToken'] = true;
    return httpManager.post('accounts:signUp', json.encode(map));
  }

  @override
  Future createUser(String localId, String email, String name, String photoUrl,
      String idToken) {
    final map = <String, Object>{};
    map['id'] = localId;
    map['email'] = email;
    map['name'] = name;
    return httpManager.postToStorage(
        'users/$localId.json?auth=$idToken', json.encode(map));
  }

  @override
  Future resetPassword(String email) {
    final map = <String, Object>{};
    map['email'] = email;
    map['requestType'] = 'PASSWORD_RESET';
    return httpManager.post('accounts:sendOobCode', json.encode(map));
  }

  @override
  Future deactivate(String idToken) {
    final map = <String, Object>{};
    map['idToken'] = idToken;
    return httpManager.post('accounts:delete', json.encode(map));
  }

  @override
  Future logout() => httpManager.post('accounts:signOut', null);
}
