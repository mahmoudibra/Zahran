import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_manager.dart';

class LocalDataManagerImpl implements LocalDataManager {
  SharedPreferences? sharedPreferences;

  @override
  Future<bool> removeData(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.remove(key.value);
  }

  @override
  Future<bool?> writeData(CachingKey key, value) async {
    sharedPreferences = await SharedPreferences.getInstance();

    print(
        "saving this value $value into local prefrence with key ${key.value}");
    Future<bool> returnedValue;
    if (value is String) {
      returnedValue = sharedPreferences!.setString(key.value, value);
    } else if (value is int) {
      returnedValue = sharedPreferences!.setInt(key.value, value);
    } else if (value is bool) {
      returnedValue = sharedPreferences!.setBool(key.value, value);
    } else if (value is double) {
      returnedValue = sharedPreferences!.setDouble(key.value, value);
    } else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  @override
  Future<bool?> readBoolean(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getBool(key.value) ?? false);
  }

  @override
  Future<double?> readDouble(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getDouble(key.value) ?? 0.0);
  }

  @override
  Future<int?> readInteger(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getInt(key.value) ?? 0);
  }

  @override
  Future<String> readString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getString(key.value) ?? "");
  }
}

class NotValidCacheTypeException implements Exception {
  String message() => "Not a valid cahing type";
}
