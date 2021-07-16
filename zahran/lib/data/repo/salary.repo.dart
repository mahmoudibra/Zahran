import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class SallaryRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ApiListResponse<SalaryModel>> pagination(int skip) async {
    return await this.paging(
      path: '/v1/mobile/salaries',
      mapItem: (json) => SalaryDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }
}
