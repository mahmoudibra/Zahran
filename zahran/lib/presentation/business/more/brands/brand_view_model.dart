import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';

class BrandListViewModel extends ListController<BrandModel> {
  final BuildContext context;

  BrandListViewModel(this.context);
  int? get id => ModalRoute.of(context)!.settings.arguments as int?;
  @override
  Future<ApiListResponse<BrandModel>> loadData(int skip) {
    return Repos.brandRepo.pagination(skip: skip, id: id);
  }
}
