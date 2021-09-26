import 'package:flutter/material.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/empty_model.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class TaskRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<EmptyModel?> completeTask({required int taskId}) async {
    var result = await get(
      path: '/v1/mobile/tasks/$taskId/complete',
      mapItem: (json) => EmptyModel(),
    );
    return result.data;
  }

  Future<TaskModel> details(int taskId) async {
    var result = await get(
      path: '/v1/mobile/tasks/$taskId',
      mapItem: (json) => TaskDto.fromJson(json).dtoToDomainModel(),
    );
    return result.data!;
  }
}
