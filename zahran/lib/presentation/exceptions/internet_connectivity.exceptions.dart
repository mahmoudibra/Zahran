import 'package:flutter/cupertino.dart';

import 'base_exception.exception.dart';

class InternetConnectivityException implements BaseException {
  @override
  String message(BuildContext context) =>
      "No Internet Connection, please try to connect to a network";
}
