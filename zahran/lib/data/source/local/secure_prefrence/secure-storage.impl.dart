import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zahran/data/source/local/secure_prefrence/secure-local-data-prefrence.dart';

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  @override
  Future<String?> readSecureKey(SecureLocalKeys key) {
    return flutterSecureStorage.read(key: key.value);
  }

  @override
  Future<void> writeKey(SecureLocalKeys key, String value) {
    return flutterSecureStorage.write(key: key.value, value: value);
  }

  @override
  Future<void> deleteAll() async {
    return await flutterSecureStorage.deleteAll();
  }
}
