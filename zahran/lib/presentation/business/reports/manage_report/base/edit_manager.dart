import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/reports/report_details/report_details_view_model.dart';

import 'manager.dart';

class EditReportViewModelManager extends ReportViewModelManager {
  final VoidCallback update;
  Box<ReportModel>? _box;
  final ReportTypes type;
  final BuildContext context;
  final ReportModel _report;
  final BranchModel _branch;
  String get _boxKey => "Reports_edit_${_branch.id}";
  EditReportViewModelManager(
    this._branch,
    this.update,
    this.type,
    this.context,
    this._report,
  );
  Box<ReportModel>? get box => _box;
  StreamSubscription<BoxEvent>? _lisner;

  Future deleteItem(ReportItem item) async {
    report.items.remove(item);
    await report.save();
  }

  ReportModel get report =>
      _box?.get("${_report.id}") ?? ReportModel(type: type);

  Future reset([ReportModel? model]) {
    return _box!.put("${_report.id}", model ?? ReportModel(type: type));
  }

  bool get hasItems => report.items.length > 0;

  @override
  Future onInit() async {
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
    _box!.put("${_report.id}", _report.copyWith());
  }

  @override
  void onClose() async {
    _lisner?.cancel();
    await _box?.clear();
    await _box?.close();
  }

  @override
  Future save() async {
    switch (type) {
      case ReportTypes.Comment:
        await Repos.reports.comment(_branch, report);
        break;
      case ReportTypes.Problem:
        await Repos.reports.problem(_branch, report);
        break;
      case ReportTypes.Competition_Sell_OUT:
        await Repos.reports.competitionSellOut(_branch, report);
        break;
      case ReportTypes.Competition_Stock_Count:
        await Repos.reports.competitionStockCount(_branch, report);
        break;
      case ReportTypes.Sell_OUT:
        await Repos.reports.sellOut(_branch, report);
        break;
      case ReportTypes.Stock_Count:
        await Repos.reports.stockCount(_branch, report);
        break;
      case ReportTypes.Return_Report:
        await Repos.reports.returnReport(_branch, report);
        break;
      case ReportTypes.Supply_Order:
        await Repos.reports.supplyOrder(_branch, report);
        break;
    }
    await box?.clear();
    await Get.find<ReportDetailsViewModel>().loadDetails(false);
  }

  @override
  bool get isReady => box?.isOpen == true;

  @override
  bool get showPopUp => false;
}
