import 'dart:convert';
import 'http_manager.dart';

abstract class UserRemoteDataSource {
  Future updateUserName(String idToken, String name);
  Future updateEmail(String idToken, String email);
  Future updatePhoto(String idToken, String photo);
  Future getUserData(String idToken);
  Future updatePassword(String idToken, String password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  HttpManager httpManager;
  Object? response;
  UserRemoteDataSourceImpl(this.httpManager);

  @override
  Future updateEmail(String idToken, String email) {
    final map = <String, Object>{};
    map['idToken'] = idToken;
    map['email'] = email;
    map['returnSecureToken'] = true;
    return httpManager.post('accounts:update', json.encode(map));
  }

  @override
  Future updateUserName(String idToken, String name) {
    final map = <String, Object>{};
    map['idToken'] = idToken;
    map['displayName'] = name;
    map['returnSecureToken'] = true;
    return httpManager.post('accounts:update', json.encode(map));
  }

  @override
  Future updatePassword(String idToken, String password) {
    final map = <String, Object>{};
    map['idToken'] = idToken;
    map['password'] = password;
    map['returnSecureToken'] = true;
    return httpManager.post('accounts:update', json.encode(map));
  }

  @override
  Future updatePhoto(String idToken, String photo) {
    final map = <String, Object>{};
    map['idToken'] = idToken;
    map['photoUrl'] = photo;
    map['returnSecureToken'] = true;
    return httpManager.post('accounts:update', json.encode(map));
  }

  @override
  Future getUserData(String idToken) {
    final map = <String, Object>{};
    map['idToken'] = idToken;
    return httpManager.post('accounts:lookup', json.encode(map));
  }
}
