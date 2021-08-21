import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';
import 'package:zahran/presentation/business/visits/visits_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/external/location/coordinates.model.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class VisitDetailsViewModel extends BaseDetailsViewModel<BranchModel> with GetLocationMixin {
  VisitDetailsViewModel(BuildContext context) : super(context);

  void goToDirections() {
    launch("https://www.google.com/maps/dir/?api=1&destination=${model.location.lat},${model.location.lang}");
  }

  void goToBrands() {
    ScreenNames.BRANDS_LIST.push(model.id);
    getCurrentPosition();
    checkEnabled();
  }

  void call() {
    launch("tel:${model.chain.media}");
  }

  routeToTaskDetailsAction(TaskModel task) {
    task.visitId = model.id;
    ScreenNames.TAS_DETAILS.push(task);
  }

  Future<void> _checkIn(BranchModel item) async {
    try {
      var position = await getCurrentPosition();
      // GeoPoint geoPoint = GeoPoint.fromPosition(position);
      GeoPoint geoPoint = GeoPoint(model.location.lat, model.location.lang);
      //TODO: static image should change later to pick image.
      await Repos.visitsRepo.checkIn(model.id, geoPoint, 50);
      model = model.copyWith(visitStatus: VisitStatus.IN_PROGRESS);
      Get.find<VisitsViewModel>().replaceItems((e) => e.id == model.id ? model : e);
    } catch (error) {
      FlareAnimation.hide(context: context);
      if (error is ApiFetchException) {
        context.errorSnackBar(error.message ?? "");
      }
    }
  }

  Future checkIn(BranchModel item) async {
    await FlareAnimation.show(action: _checkIn(item), context: context);
  }

  Future checkOut(BranchModel item) async {}
}
