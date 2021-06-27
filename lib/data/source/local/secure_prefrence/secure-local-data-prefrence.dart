import 'package:zahran/presentation/helpers/enums/enumeration.dart';

abstract class SecureStorage {
  Future<String> readSecureKey(SecureLocalKeys key);

  Future<void> writeKey(SecureLocalKeys key, String value);

  Future<void> deleteAll();
}

class UserTypes extends Enum<String> {
  const UserTypes(String val) : super(val);
  static const UserTypes USER = const UserTypes('USER');
  static const UserTypes GUEST = const UserTypes('GUEST');
}

class SecureLocalKeys extends Enum<String> {
  const SecureLocalKeys(String val) : super(val);
  static const SecureLocalKeys USER_AUTH_KEY = const SecureLocalKeys('USER_AUTH_KEY');
  static const SecureLocalKeys USER_MOBILE_NUMBER = const SecureLocalKeys('USER_MOBILE_NUMBER');
  static const SecureLocalKeys USER_TYPE_KEY = const SecureLocalKeys('USER_TYPE_KEY');
  static const SecureLocalKeys USER_ID_KEY = const SecureLocalKeys('USER_ID_KEY');
  static const SecureLocalKeys USER_KEY = const SecureLocalKeys('USER_KEY');
}
