import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/promotion.dto.dart';
import 'package:zahran/domain/models/promotion.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class PromotionRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ApiListResponse<Promotion>> pagination({required int skip, required PromotionStatus filterType}) async {
    return await this.paging(
      path: '/v1/mobile/promotions',
      queryParams: {"filter": filterType.value},
      mapItem: (json) => PromotionDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }

  Future<Promotion?> fetchPromotionDetails(int promotionID) async {
    var result = await get(
      path: '/v1/mobile/promotions/$promotionID',
      mapItem: (json) => PromotionDto.fromJson(json).dtoToDomainModel(),
    );
    return result.data;
  }
}
