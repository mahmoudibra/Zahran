import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/external/location/coordinates.model.dart';
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

  Future checkIn(int id, GeoPoint geoPoint, int imageId) async {
    return await this.post(
      path: '/v1/mobile/branches/checkin',
      data: {
        "branch_id": id,
        "lat": geoPoint.lat,
        "lang": geoPoint.long,
        "image_id": imageId,
      },
      mapItem: (json) => BranchDto.fromJson(json).dtoToDomainModel(),
    );
  }

  Future checkOut(int id) async {
    return await this.get(
      path: '/v1/mobile/branches/checkout',
      queryParams: {"branch_id": id},
      mapItem: (json) => BranchDto.fromJson(json).dtoToDomainModel(),
    );
  }

  Future<BranchModel> details(int id) async {
    return await this
        .get(
          path: '/v1/mobile/branches/visit-details',
          queryParams: {"branch_id": id},
          mapItem: (json) => BranchDto.fromJson(json).dtoToDomainModel(),
        )
        .then((value) => value.data!);
  }
}
