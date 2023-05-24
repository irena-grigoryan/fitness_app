import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorageService {
  static final _storage = FlutterSecureStorage();

  static Future createData(String key, String value) async {
    var createData = await _storage.write(key: key, value: value);
    return createData;
  }

  static Future getData(String key) async {
    var getData = await _storage.read(key: key);
    return getData;
  }

  static Future deleteData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
