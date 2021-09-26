import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

abstract class BaseDetailsViewModel<T> extends GetxController {
  final BuildContext context;
  late T _model;
  T get model => _model;
  bool _loading = false;
  String? _error;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get loading => _loading;
  void onChanged() {}
  BaseDetailsViewModel(this.context) {
    _model = ModalRoute.of(context)!.settings.arguments as T;
  }

  Future loadDetails([bool isLoading = true]) async {
    if (_loading == true) return;
    if (isLoading) _loading = true;
    _error = null;
    update();
    try {
      _model = await fetchDetails();
      onChanged();
      if (isLoading) _loading = false;
      _error = null;
    } catch (e) {
      if (isLoading) _loading = false;
      _error = e.toString();
    }
    update();
  }

  Future<T> fetchDetails();

  @protected
  set model(T n) {
    _model = n;
    onChanged();
    update();
  }

  T? getController<T extends GetxController>() {
    if (Get.isRegistered<T>()) return Get.find<T>();
    return null;
  }

  @override
  void onInit() {
    loadDetails();
    super.onInit();
  }
}
