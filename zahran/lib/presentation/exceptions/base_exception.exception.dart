import 'package:flutter/widgets.dart';

abstract class BaseException implements Exception {
  String message(BuildContext context);
}
