import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';

class ReportListViewModel extends ListController<BranchReport>
    with GetLocationMixin {
  final BuildContext context;
  final String type;
  ReportListViewModel(this.context, this.type);

  @override
  Future<ApiListResponse<BranchReport>> loadData(int skip) async {
    return Repos.reports.reports(skip, type, await getCurrentPosition(true));
  }
}
