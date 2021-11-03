import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class ReportsRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<ReportModel> _report(
      String path, BranchModel branch, ReportModel model) async {
    return await this
        .post(
          path: '/v1/mobile/report/$path',
          data: {
            ...model.toJson(),
            "branch_id": branch.id,
          },
          mapItem: (json) => ReportDto.fromJson(json).dtoToDomainModel(),
        )
        .then((value) => value.data!);
  }

  Future<ReportModel> problem(
      BranchModel branchModel, ReportModel model) async {
    return await this
        .post(
          path: '/v1/mobile/tickets',
          data: {
            ...model.toJson(),
            "branch_id": branchModel.id,
          },
          mapItem: (json) => ReportDto.fromJson(json).dtoToDomainModel(),
        )
        .then((value) => model.copyWith(id: value.data!.id));
  }

  Future<ApiListResponse<SelectItem>> problemTypes() async {
    return await this.paging(
      path: '/v1/mobile/ticket_types',
      skip: 0,
      mapItem: (json) => SelectItemDto.fromJson(json).dtoToDomainModel(),
    );
  }

  Future<ReportModel> comment(BranchModel branch, ReportModel model) =>
      _report('comment', branch, model);
  Future<ReportModel> competitionSellOut(
          BranchModel branch, ReportModel model) =>
      _report('competition-sell-out', branch, model);
  Future<ReportModel> competitionStockCount(
          BranchModel branch, ReportModel model) =>
      _report('competition-stock-count', branch, model);
  Future<ReportModel> sellOut(BranchModel branch, ReportModel model) =>
      _report('sell-out', branch, model);
  Future<ReportModel> stockCount(BranchModel branch, ReportModel model) =>
      _report('stock-count', branch, model);
  Future<ReportModel> returnReport(BranchModel branch, ReportModel model) =>
      _report('return-report', branch, model);
  Future<ReportModel> supplyOrder(BranchModel branch, ReportModel model) =>
      _report('supply-order', branch, model);

  //List
  Future<ApiListResponse<BranchReport>> reports(int skip, String type,
      [Position? position]) async {
    return await this.paging(
      path: '/v1/mobile/reports',
      queryParams: {
        "date_filter": type,
        "lat": position?.latitude,
        "lang": position?.longitude,
      },
      mapItem: (json) => BranchReportDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }

  Future<ApiListResponse<ReportModel>> visitReports(int skip, int id,
      [Position? position]) async {
    return await this.paging(
      path: '/v1/mobile/visit-reports/$id',
      resolveResponse: (response) {
        var resolved = resolveResponse(response);
        return {
          ...resolved,
          "data": resolved["data"]["reports"],
        };
      },
      queryParams: {
        "lat": position?.latitude,
        "lang": position?.longitude,
      },
      mapItem: (json) => ReportDto.fromJson(json).dtoToDomainModel(),
      skip: skip,
    );
  }

  Future<ReportModel> reportDetails(int id) {
    return this
        .get(
          path: '/v1/mobile/show_report/$id',
          mapItem: (json) => ReportDto.fromJson(json).dtoToDomainModel(),
        )
        .then((value) => value.data!);
  }

  Future<ReportModel> ticketDetails(int id) {
    return this
        .get(
          path: '/v1/mobile/tickets/$id',
          mapItem: (json) => ReportDto.fromTicketsJson(json).dtoToDomainModel(),
        )
        .then((value) => value.data!);
  }

  Future resolveTicket(int id) {
    return this
        .get(
          path: '/v1/mobile/tickets/$id/resolve',
          mapItem: (json) => json,
        )
        .then((value) => value.data!);
  }
}
