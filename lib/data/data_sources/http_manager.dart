import 'dart:convert';
import 'dart:async';
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
      if (response.statusCode == 400) {
        final resp = json.decode(response.body);
        var error = resp['error']['message'] ?? 'Error';
        throw getExceptionMessage(error);
      }
    } catch (e) {
      throw (e);
    }
  }

  String getExceptionMessage(e) {
    print(e);
    switch (e) {
      case 'EMAIL_NOT_FOUND':
        return 'User not found';
      case 'INVALID_EMAIL':
        return 'Enter a valid email';
      case 'INVALID_PASSWORD':
        return 'Password is incorrect';
      case 'EMAIL_EXISTS':
        return 'Email is already registered';
      case 'INVALID_ID_TOKEN':
        return 'Log in again before retrying this request';
      default:
        return e ?? 'Error';
    }
  }
}
