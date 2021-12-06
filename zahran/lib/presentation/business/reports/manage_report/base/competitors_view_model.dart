import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/localization/tr.dart';

class CompetitorsViewModel extends BaseListController<CompetitorModel>
    with SelectFormController {
  final BranchModel branch;
  CompetitorsViewModel(this.branch);
  @override
  Iterable<CompetitorModel> get items =>
      [...branch.competitors, CompetitorModel.withName("")];

  @override
  bool checkSelected(CompetitorModel left, CompetitorModel right) {
    return left.id == right.id;
  }

  @override
  String getDisplay(BuildContext context, CompetitorModel item) {
    if (item.id == null) return TR.of(context).other;
    return item.name.format(context);
  }
}
