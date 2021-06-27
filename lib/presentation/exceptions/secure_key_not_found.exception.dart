import 'base-exception.exception.dart';

class SecureKeyNotFoundException implements BaseException {
  @override
  String message() => "This key isn't exist";
}
