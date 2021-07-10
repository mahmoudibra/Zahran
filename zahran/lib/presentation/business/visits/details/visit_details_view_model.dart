import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/visits/visits_view_model.dart';

class VisitDetailsViewModel extends GetxController {
  late BranchModel _model;
  BranchModel get model => _model;
  VisitDetailsViewModel(BuildContext context) {
    _model = ModalRoute.of(context)!.settings.arguments as BranchModel;
  }

  void goToDirections(BranchModel model) {
    launch(
        "https://www.google.com/maps/dir/?api=1&destination=${model.location.lat},${model.location.lang}");
  }

  void call(BranchModel model) {
    launch("tel:${model.chain.media}");
  }

  Future checkIn(BranchModel model) async {
    _model = model.copyWith(visitStatus: VisitStatus.IN_PROGRESS);
    Get.find<VisitsViewModel>()
        .replaceItems((e) => e.id == model.id ? _model : e);
    update();
  }
}
