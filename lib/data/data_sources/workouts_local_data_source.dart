import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class WorkoutsLocalDataSource {
  Future deleteData(String key);
  Future getData(String key);
  Future createData(String key, String value);
}

class WorkoutsLocalDataSourceImpl implements WorkoutsLocalDataSource {
  final _storage = FlutterSecureStorage();

  @override
  Future createData(String key, String value) async {
    var createData = await _storage.write(key: key, value: value);
    return createData;
  }

  @override
  Future getData(String key) async {
    var getData = await _storage.read(key: key);
    return getData;
  }

  @override
  Future deleteData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
