import 'package:flutter/material.dart';

import 'base_exception.exception.dart';

class LocationServiceException implements BaseException {
  @override
  String message(BuildContext context) =>
      "Location service not enabled, please enable it";
}
