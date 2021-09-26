import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';

import 'manager.dart';

class CreateReportViewModelManager extends ReportViewModelManager {
  final VoidCallback update;
  Box<ReportModel>? _box;
  final ReportTypes type;
  final BuildContext context;
  final String _boxKey;
  CreateReportViewModelManager(
    this._boxKey,
    this.update,
    this.type,
    this.context,
  );
  Box<ReportModel>? get box => _box;
  StreamSubscription<BoxEvent>? _lisner;

  Future deleteItem(ReportItem item) async {
    report.items.remove(item);
    await report.save();
  }

  ReportModel get report => _box?.get("${type}") ?? ReportModel(type: type);

  Future reset([ReportModel? model]) {
    return _box!.put("${type}", model ?? ReportModel(type: type));
  }

  bool get hasItems => report.items.length > 0;

  @override
  void onInit() async {
    if (Hive.isBoxOpen(_boxKey)) {
      _box = Hive.box(_boxKey);
    } else
      await Hive.openBox<ReportModel>(_boxKey).then((value) {
        _box = value;
        update();
      });
    _lisner = _box?.watch().listen((event) {
      update();
    });
    if (!_box!.containsKey("${type}")) {
      _box!.put("${type}", ReportModel(type: type));
    }
  }

  @override
  void onClose() {
    _lisner?.cancel();
    _box?.close();
  }

  @override
  Future save() async {
    switch (type) {
      case ReportTypes.Comment:
        await Repos.reports.comment(report);
        Get.find<VisitDetailsViewModel>().commentReportDone();
        break;
      case ReportTypes.Problem:
        await Repos.reports.problem(report);
        Get.find<VisitDetailsViewModel>().proplemReportDone();
        break;
      case ReportTypes.Competition_Sell_OUT:
        await Repos.reports.competitionSellOut(report);
        Get.find<VisitDetailsViewModel>().competitionSellOutDone();
        break;
      case ReportTypes.Competition_Stock_Count:
        await Repos.reports.competitionStockCount(report);
        Get.find<VisitDetailsViewModel>().competitionStockCountDone();
        break;
      case ReportTypes.Sell_OUT:
        await Repos.reports.sellOut(report);
        Get.find<VisitDetailsViewModel>().sellOutDone();
        break;
      case ReportTypes.Stock_Count:
        await Repos.reports.stockCount(report);
        Get.find<VisitDetailsViewModel>().stockCountDone();
        break;
      case ReportTypes.Return_Report:
        await Repos.reports.returnReport(report);
        Get.find<VisitDetailsViewModel>().returnReportDone();
        break;
      case ReportTypes.Supply_Order:
        await Repos.reports.supplyOrder(report);
        Get.find<VisitDetailsViewModel>().supplyOrderDone();
        break;
    }
    await box?.clear();
  }

  @override
  bool get isReady => box?.isOpen == true;

  @override
  bool get showPopUp => true;
}
