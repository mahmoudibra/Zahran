import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/reports/branch_report_list/branch_report_list_view_model.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';

import 'create_manager.dart';
import 'edit_manager.dart';
import 'manager.dart';

class ReportViewModel extends GetxController {
  late final ReportViewModelManager manager;
  late final BranchModel _branch;
  final ReportTypes type;
  final BuildContext context;

  ReportViewModel(this.type, this.context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is ReportModel) {
      _branch = Get.find<BranchReportListViewModel>().report.branch;
      manager =
          EditReportViewModelManager(_branch, update, type, context, args);
    } else {
      _branch = Get.find<VisitDetailsViewModel>().model;
      manager = CreateReportViewModelManager(_branch, update, type, context);
    }
  }
  BranchModel get branch => _branch;

  String? _query;
  String? get query => _query;
  List<BrandModel> get brands => _branch.brands
      .where((element) =>
          element.name.contains(_query) ||
          element.products.any((p) => p.name.contains(_query)))
      .toList();
  void search(String? v) {
    if (_query == v) return;
    _query = v;
    update();
  }

  @override
  void onInit() async {
    await manager.onInit();
    var competitor = manager.report.competitor;
    if (competitor != null && competitor.id != null && competitor.id! > 0) {
      var _new =
          _branch.competitors.firstOrDefault((f) => f.id == competitor.id);
      manager.report.competitor = _new;
      manager.report.save();
    }
    super.onInit();
  }

  @override
  void onClose() {
    manager.onClose();
    super.onClose();
  }
}
