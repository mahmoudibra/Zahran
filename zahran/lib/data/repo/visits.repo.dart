import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class VisitsRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ApiListResponse<BranchModel>> pagination(int skip,
      [Position? position]) async {
    return await this.paging(
      path: '/v1/mobile/branches',
      queryParams: {
        "lat": position?.latitude,
        "lang": position?.longitude,
      },
      mapItem: (json) => BranchDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }

  Future checkIn(int id, Position position, int imageId) async {
    return await this.post(
      path: '/v1/mobile/branches/checkin',
      data: {
        "branch_id": id,
        "lat": position.latitude,
        "lang": position.longitude,
        "image_id": imageId,
      },
      mapItem: (json) => BranchDto.fromJson(json).dtoToDomainModel(),
    );
  }
}
