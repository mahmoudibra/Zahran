import 'package:flutter/material.dart';

import 'base_exception.exception.dart';

class SecureKeyNotFoundException implements BaseException {
  @override
  String message(BuildContext context) => "This key isn't exist";
}
