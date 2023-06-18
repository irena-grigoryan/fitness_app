import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/extensions/app_exceptions.dart';
import 'package:fitness_app/api.dart' as api;
import 'package:http/http.dart' as http;

abstract class HttpManager {
  Future post(String path, Object? body);
  Future get(String path);
  Future postToStorage(String path, Object? body);
  Future getFromStorage(String path);
}

class HttpManagerImpl implements HttpManager {
  final String url = api.url;
  final String storageUrl = api.storageUrl;
  final String apiKey = api.apiKey;

  @override
  Future post(String path, Object? body) async {
    final response =
        await http.post(Uri.parse('${url + path + apiKey}'), body: body);
    return inspectResponse(response);
  }

  @override
  Future<dynamic> get(String path) async {
    final response = await http.get(Uri.parse('${url + path + apiKey}'));
    return inspectResponse(response);
  }

  @override
  Future postToStorage(String path, Object? body) async {
    final response =
        await http.post(Uri.parse('${storageUrl + path}'), body: body);
    return inspectResponse(response);
  }

  @override
  Future getFromStorage(String path) async {
    final response = await http.get(Uri.parse('${storageUrl + path}'));
    return inspectResponse(response);
  }

  inspectResponse(http.Response response) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  String getExceptionMessage(FirebaseAuthException e) {
    print(e.code);
    switch (e.code) {
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Password is incorrect';
      case 'requires-recent-login':
        return 'Log in again before retrying this request';
      default:
        return e.message ?? 'Error';
    }
  }
}
