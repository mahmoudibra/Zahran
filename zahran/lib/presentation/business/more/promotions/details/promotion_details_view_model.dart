import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/localization/tr.dart';

class PromotionDetailsViewModel extends GetxController {
  final BuildContext context;
  final int promotionId;
  Promotion promotion = Promotion.empty();

  PromotionDetailsViewModel(this.context, this.promotionId);

  Future _fetchPromotionDetails() async {
    try {
      promotion = (await Repos.promotionRepo.fetchPromotionDetails(promotionId))!;
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
}
