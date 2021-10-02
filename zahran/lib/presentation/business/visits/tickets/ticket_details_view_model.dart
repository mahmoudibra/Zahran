import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../visits_view_model.dart';

class TicketDetailsViewModel extends BaseDetailsViewModel<ReportModel> {
  TicketDetailsViewModel(BuildContext context) : super(context);

  @override
  Future<ReportModel> fetchDetails() {
    return Repos.reports.ticketDetails(model.id!);
  }

  Future resolve() async {
    try {
      await Repos.reports.resolveTicket(model.id!);
      getController<VisitDetailsViewModel>()?.setProblemResolved(model.id!);
      getController<VisitsViewModel>()?.setProblemResolved(model.id!);
      ScreenRouter.pop();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
