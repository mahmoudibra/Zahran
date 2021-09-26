import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';

class BranchReportListViewModel extends ListController<ReportModel>
    with GetLocationMixin {
  final BuildContext context;
  late BranchReport report;
  BranchReportListViewModel(this.context) {
    report = ModalRoute.of(context)!.settings.arguments as BranchReport;
  }

  @override
  Future<ApiListResponse<ReportModel>> loadData(int skip) async {
    return Repos.reports
        .visitReports(skip, report.id, await getCurrentPosition(true));
  }
}
