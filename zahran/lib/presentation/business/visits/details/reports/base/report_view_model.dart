import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';

const _boxKey = "Reports_box_1";

class ReportViewModel extends GetxController {
  late BranchModel _branch;
  final ReportTypes type;
  final BuildContext context;
  Box<ReportModel>? _box;
  Box<ReportModel>? get box => _box;
  StreamSubscription<BoxEvent>? _lisner;
  ReportViewModel(this.type, this.context) {
    _branch = Get.find<VisitDetailsViewModel>().model;
  }

  List<BrandModel> get brands => _branch.brands
      .where((element) =>
          element.name.contains(_query) ||
          element.products.any((p) => p.name.contains(_query)))
      .toList();
  String? _query;
  String? get query => _query;
  void search(String? v) {
    if (_query == v) return;
    _query = v;
    update();
  }

  Future deleteItem(ReportItem item) async {
    report.items.remove(item);
    await report.save();
  }

  ReportModel get report => _box?.get("${type}") ?? ReportModel(type: type);

  Future reset([ReportModel? model]) {
    return _box!.put("${type}", model ?? ReportModel(type: type));
  }

  bool get hasItems => report.items.length > 0;

  @override
  void onInit() async {
    if (Hive.isBoxOpen(_boxKey)) {
      _box = Hive.box(_boxKey);
    } else
      await Hive.openBox<ReportModel>(_boxKey).then((value) {
        _box = value;
        update();
      });
    _lisner = _box?.watch().listen((event) {
      update();
    });
    if (!_box!.containsKey("${type}")) {
      _box!.put("${type}", ReportModel(type: type));
    }

    super.onInit();
  }

  @override
  void onClose() {
    _lisner?.cancel();
    _box?.close();
    super.onClose();
  }
}
