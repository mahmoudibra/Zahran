import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class BaseDetailsViewModel<T> extends GetxController {
  final BuildContext context;
  late T _model;
  T get model => _model;
  BaseDetailsViewModel(this.context) {
    _model = ModalRoute.of(context)!.settings.arguments as T;
  }
  @protected
  set model(T n) {
    _model = n;
    update();
  }
}
