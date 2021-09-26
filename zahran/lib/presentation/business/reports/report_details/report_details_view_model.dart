import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';

class ReportDetailsViewModel extends BaseDetailsViewModel<ReportModel> {
  ReportDetailsViewModel(BuildContext context) : super(context);

  @override
  Future<ReportModel> fetchDetails() {
    return Repos.reports.reportDetails(model.id!);
  }
}
