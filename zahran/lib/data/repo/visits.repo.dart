import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class VisitsRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ApiListResponse<BranchModel>> pagination(int skip) async {
    return await this.paging(
      path: '/v1/mobile/branches',
      mapItem: (json) => BranchDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }
}
