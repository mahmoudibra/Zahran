import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';

class VisitsViewModel extends ListController<BranchModel> with GetLocationMixin {
  final BuildContext context;

  VisitsViewModel(this.context);

  @override
  Future<ApiListResponse<BranchModel>> loadData(int skip) async {
    return Repos.visitsRepo.pagination(skip, await getCurrentPosition(true));
  }
}
