import 'base_exception.exception.dart';

class SecureKeyNotFoundException implements BaseException {
  @override
  String message() => "This key isn't exist";
}
