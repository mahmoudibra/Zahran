import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class VisitsRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext;

  Future<ApiListResponse<Map>> pagination(int skip) async {
    return await this.paging(
      path: '/v1/mobile/branches',
      mapItem: (json) => json,
      skip: skip,
    );
  }
}
