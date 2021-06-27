import 'base-exception.exception.dart';

class InternetConnectivityException implements BaseException {
  @override
  String message() =>
      "No Internet Connection, please try to connect to a network";
}
