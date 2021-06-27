import 'base_exception.exception.dart';

class LocationServiceException implements BaseException {
  @override
  String message() => "Location service not enabled, please enable it";
}
