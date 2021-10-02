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
      manager = EditReportViewModelManager(update, type, context, args);
    } else {
      _branch = Get.find<VisitDetailsViewModel>().model;
      manager = CreateReportViewModelManager(
          "Reports_${_branch.id}", update, type, context);
    }
  }

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
    manager.onInit();

    super.onInit();
  }

  @override
  void onClose() {
    manager.onClose();
    super.onClose();
  }
}
