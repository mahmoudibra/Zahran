import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';

class CheckInListViewModel extends ListController<BranchModel> with GetLocationMixin {
  final BuildContext context;

  String? _query;

  CheckInListViewModel(this.context);

  void search(String? v) {
    if (_query == v) return;
    _query = v;
    update();
  }

  String? get query => _query;
  Iterable<BranchModel> get filtered => items.where((element) => element.name.hasName(_query ?? ""));

  @override
  Future<ApiListResponse<BranchModel>> loadData(int skip) async {
    return Repos.visitsRepo.pagination(skip, await getCurrentPosition(true));
  }
}
