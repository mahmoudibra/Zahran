import 'dart:core';

import 'package:zahran/presentation/helpers/enums/enumeration.dart';

abstract class LocalDataManager {
  Future<bool> writeData(CachingKey key, dynamic value);

  Future<bool> removeData(CachingKey key);

  Future<String> readString(CachingKey key);

  Future<int> readInteger(CachingKey key);

  Future<bool> readBoolean(CachingKey key);

  Future<double> readDouble(CachingKey key);
}

class CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);
  static const CachingKey VENDOR_TYPE = const CachingKey('VENDOR_TYPE');
  static const CachingKey LOCAL_CART = const CachingKey('LOCAL_CART');
}
