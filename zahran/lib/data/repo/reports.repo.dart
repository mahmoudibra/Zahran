import 'package:flutter/material.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class ReportsRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ReportModel> _report(String path, ReportModel model) async {
    return await this
        .post(
          path: '/v1/mobile/report/$path',
          data: model.toJson(),
          mapItem: (json) => ReportDto.fromJson(json).dtoToDomainModel(),
        )
        .then((value) => value.data!);
  }

  Future<ReportModel> comment(ReportModel model) => _report('comment', model);
  Future<ReportModel> competitionSellOut(ReportModel model) =>
      _report('competition-sell-out', model);
  Future<ReportModel> competitionStockCount(ReportModel model) =>
      _report('competition-stock-count', model);
  Future<ReportModel> sellOut(ReportModel model) => _report('sell-out', model);
  Future<ReportModel> stockCount(ReportModel model) =>
      _report('stock-count', model);
  Future<ReportModel> returnReport(ReportModel model) =>
      _report('return-report', model);
  Future<ReportModel> supplyOrder(ReportModel model) =>
      _report('supply-order', model);
}
