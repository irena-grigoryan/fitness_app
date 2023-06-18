import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future setUserKeys(String? token, String? localId);
  Future getUserKeys();
  Future<bool> setResponseId(String? id);
  Future<bool> setIdToken(String? token);
  Future<bool> setLocalId(String? localId);
  Future<String?> getResponseId();
  Future<bool> clearData();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future getUserKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final idToken = prefs.getString('idToken');
    final localId = prefs.getString('localId');
    return {
      'idToken': idToken,
      'localId': localId,
    };
  }

  @override
  Future setUserKeys(String? idToken, String? localId) async {
    await setIdToken(idToken);
    await setLocalId(localId);
  }

  @override
  Future<bool> setIdToken(String? idToken) async {
    final prefs = await SharedPreferences.getInstance();
    if (idToken != null) {
      return prefs.setString('idToken', idToken);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> setLocalId(String? localId) async {
    final prefs = await SharedPreferences.getInstance();
    if (localId != null) {
      return prefs.setString('localId', localId);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> setResponseId(String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    if (userId != null) {
      return prefs.setString('responseId', userId);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<String?> getResponseId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('responseId');
  }

  @override
  Future<bool> clearData() => Future(() => SharedPreferences.getInstance())
      .then((value) => value.clear());
}
