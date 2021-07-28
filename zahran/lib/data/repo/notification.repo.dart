import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class NotificationRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ApiListResponse<NotificationModel>> pagination(int skip, [Position? position]) async {
    return await this.paging(
      path: '/v1/mobile/messages',
      mapItem: (json) => NotificationDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }

  Future<NotificationModel?> fetchNotificationDetails(int notificationID) async {
    var result = await get(
      path: '/v1/mobile/messages/$notificationID',
      mapItem: (json) => NotificationDto.fromJson(json).dtoToDomainModel(),
    );
    return result.data;
  }
}
