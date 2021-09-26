import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/localization/tr.dart';

class NotificationDetailsViewModel
    extends BaseDetailsViewModel<NotificationModel> {
  final BuildContext context;
  NotificationModel notification = NotificationModel.empty();

  NotificationDetailsViewModel(this.context) : super(context);

  Future _fetchPromotionDetails() async {
    try {
      notification =
          (await Repos.notificationRepo.fetchNotificationDetails(model.id))!;
      update();
    } catch (error) {
      if (!(error is ApiFetchException)) {
        context.errorSnackBar(TR.of(context).un_expected_error);
      }
    }
  }

  @override
  void onReady() {
    FlareAnimation.show(action: _fetchPromotionDetails(), context: context);
    super.onReady();
  }

  @override
  Future<NotificationModel> fetchDetails() async {
    //TODO load details
    return notification;
  }
}
