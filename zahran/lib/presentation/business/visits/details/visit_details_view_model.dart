import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable/reusable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';
import 'package:zahran/presentation/business/base/get_location_mixin.dart';
import 'package:zahran/presentation/business/visits/visits_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/external/location/coordinates.model.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class VisitDetailsViewModel extends BaseDetailsViewModel<BranchModel>
    with GetLocationMixin {
  VisitDetailsViewModel(BuildContext context) : super(context);

  void goToDirections() {
    launch(
        "https://www.google.com/maps/dir/?api=1&destination=${model.location.lat},${model.location.lang}");
  }

  void goToBrands() {
    ScreenNames.BRANDS_LIST.push(model.id);
    getCurrentPosition();
    checkEnabled();
  }

  void call() {
    launch("tel:${model.chain.media}");
  }

  setTaskCompleted(int id) {
    model = model.copyWith(
      tasks: model.tasks
          .map((e) => e.id == id ? e.copyWith(isCompleted: true) : e)
          .toList(),
    );
    update();
  }

  setProblemResolved(int id) {
    model = model.copyWith(
      tickets: model.tickets
          .map((e) => e.id == id
              ? e.copyWith(problem: e.problem?.copyWith(resolved: true))
              : e)
          .toList(),
    );
    update();
  }

  commentReportDone() {
    model = model.copyWith(comment: true);
    update();
  }

  proplemReportDone(ReportModel report) {
    model = model.copyWith(tickets: [...model.tickets, report]);
    update();
  }

  competitionSellOutDone() {
    model = model.copyWith(competitionSellOut: true);
    update();
  }

  competitionStockCountDone() {
    model = model.copyWith(competitionStockCount: true);
    update();
  }

  returnReportDone() {
    model = model.copyWith(returnReport: true);
    update();
  }

  sellOutDone() {
    model = model.copyWith(sellOut: true);
    update();
  }

  stockCountDone() {
    model = model.copyWith(stockCount: true);
    update();
  }

  supplyOrderDone() {
    model = model.copyWith(supplyOrder: true);
    update();
  }

  routeToTaskDetailsAction(TaskModel task) {
    task.visitId = model.id;
    ScreenNames.TAS_DETAILS.push(task);
  }

  Future<Media?> _pickAndUploadMedia(ValueNotifier<double?> notifier) async {
    var image = await ImagePicker().pickImage(
        source: kDebugMode ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1200);
    if (image == null) {
      throw TR.of(context).you_must_take_image;
    }
    var mediaFile = MediaLocal(
      mediaFile: File(image.path),
      mediaFileTypes: MediaFileTypes.IMAGE,
      fileName: image.name,
    );
    return await mediaFile.compressAndUpload(
      notifier: notifier,
      upload: (file, onProgress) async {
        return await Repos.mediaRepo.uploadMedia(
          uploadedFile: file,
          mediaFileTypes: mediaFile.mediaFileTypes,
          onProgress: onProgress,
        );
      },
    );
  }

  Future<void> _checkIn(
    ValueNotifier<double?> notifier,
    BranchModel item,
    BuildContext context,
  ) async {
    var media = await _pickAndUploadMedia(notifier);
    var position = await getCurrentPosition();
    GeoPoint geoPoint = kDebugMode
        ? GeoPoint(model.location.lat, model.location.lang)
        : GeoPoint.fromPosition(position);

    await Repos.visitsRepo.checkIn(model.id, geoPoint, media!.id);
    model = model.copyWith(visitStatus: VisitStatus.IN_PROGRESS);
    Get.find<VisitsViewModel>()
        .replaceItems((e) => e.id == model.id ? model : e);
  }

  Future checkIn(BranchModel item, BuildContext context) async {
    await FlareAnimation.show(
      action: (notifier) => _checkIn(notifier, item, context),
      context: context,
    );
  }

  Future checkOut(BranchModel item) async {
    // var unCompletedTask = model.tasks.where((task) => !task.isCompleted);
    // if (unCompletedTask.isNotEmpty) {
    //   context
    //       .errorSnackBar(TR.of(context).complete_all_your_tasks_please_first);
    //   return;
    // }
    await FlareAnimation.show(
        action: (notifier) => _checkout(notifier), context: context);
  }

  Future<void> _checkout(ValueNotifier<double?> notifier) async {
    var media = await _pickAndUploadMedia(notifier);
    var position = await getCurrentPosition();
    GeoPoint geoPoint = kDebugMode
        ? GeoPoint(model.location.lat, model.location.lang)
        : GeoPoint.fromPosition(position);

    await Repos.visitsRepo.checkOut(model.id, geoPoint, media!.id);
    model = model.copyWith(visitStatus: VisitStatus.COMPLETED);
    Get.find<VisitsViewModel>()
        .replaceItems((e) => e.id == model.id ? model : e);
  }

  @override
  Future<BranchModel> fetchDetails() {
    return Repos.visitsRepo.details(model.id);
  }
}
