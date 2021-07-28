import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/more/promotions/details/promotion_details_view_model.dart';
import 'package:zahran/presentation/commom/rounded_image.dart';
import 'package:zahran/presentation/commom/scaffold_silver_app_bar.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/helpers/date/date-manager.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../../../../../r.dart';
import '../PromotionStatus.dart';

class PromotionDetailsScreen extends StatelessWidget {
  PromotionDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PromotionDetailsViewModel(context),
      builder: (PromotionDetailsViewModel vm) {
        return ScaffoldSilverAppBar(
          content: promotionDetailsContent(context, vm),
          title: TR.of(context).promotion_details,
        );
      },
    );
  }

  Widget promotionDetailsContent(BuildContext context, PromotionDetailsViewModel vm) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          promotionImage(context, vm),
          ViewsToolbox.emptySpaceWidget(height: 12),
          promotionTitle(context, vm),
          ViewsToolbox.emptySpaceWidget(height: 12),
          campaignDetails(context),
          ViewsToolbox.emptySpaceWidget(height: 8),
          promotionDate(context, vm),
          ViewsToolbox.emptySpaceWidget(height: 8),
          promotionDescription(context, vm),
          // ViewsToolbox.emptySpaceWidget(height: 16),
          // displayTypeHeader(context),
          // ViewsToolbox.emptySpaceWidget(height: 4),
          // displayTypeTitle(context),
          // displayTypeDescription(context),
          ViewsToolbox.emptySpaceWidget(height: 24),
          chainDetailsSection(context, vm),
          ViewsToolbox.emptySpaceWidget(height: 24),
          subBrandSection(context, vm),
          ViewsToolbox.emptySpaceWidget(height: 24),
        ],
      ),
    );
  }

  Widget promotionImage(BuildContext context, PromotionDetailsViewModel vm) {
    return ShapedRemoteImage(
      url: vm.promotion.cover,
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
    );
  }

  Widget promotionTitle(BuildContext context, PromotionDetailsViewModel vm) {
    return Row(
      children: [
        Expanded(
          child: Text(
            vm.promotion.title.format(context),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        PromotionStatusWidget(promotionStatus: vm.promotion.status),
        ViewsToolbox.emptySpaceWidget(width: 1),
      ],
    );
  }

  Widget promotionDescription(BuildContext context, PromotionDetailsViewModel vm) {
    return Text(
      vm.promotion.description.format(context),
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget displayTypeHeader(BuildContext context) {
    return Text(
      TR.of(context).display_type,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }

  Widget displayTypeTitle(BuildContext context) {
    return Text(
      "Static display type",
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget displayTypeDescription(BuildContext context) {
    return Text(
      "Static display description",
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }

  Widget chainTitle(BuildContext context) {
    return Text(
      TR.of(context).chain,
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget chainDetailsSection(BuildContext context, PromotionDetailsViewModel vm) {
    if (vm.promotion.chain.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chainTitle(context),
          ViewsToolbox.emptySpaceWidget(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedImage(
                radius: 32,
                borderSize: 2,
                imageUrl: vm.promotion.chain[0].media,
                borderColor: Theme.of(context).dividerColor,
                loadingIndicatorSize: 16,
              ),
              ViewsToolbox.emptySpaceWidget(width: 12),
              Text(
                vm.promotion.chain[0].title.format(context),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Theme.of(context).textTheme.headline6?.color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      );
    } else {
      return ViewsToolbox.emptyWidget();
    }
  }

  Widget subBrandTitle(BuildContext context) {
    return Text(
      TR.of(context).sub_brand,
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget subBrandSection(BuildContext context, PromotionDetailsViewModel vm) {
    return vm.promotion.products.length != 0
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subBrandTitle(context),
              ViewsToolbox.emptySpaceWidget(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundedImage(
                    radius: 32,
                    borderSize: 2,
                    imageUrl: vm.promotion.products[0].media,
                    borderColor: Theme.of(context).dividerColor,
                    loadingIndicatorSize: 16,
                  ),
                  ViewsToolbox.emptySpaceWidget(width: 12),
                  Text(
                    vm.promotion.products[0].name.format(context),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Theme.of(context).textTheme.headline6?.color, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          )
        : ViewsToolbox.emptyWidget();
  }

  Widget campaignDetails(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            TR.of(context).campaign_details,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          width: 12,
          height: 12,
          child: Image.asset(R.assetsImagesCupponIcon),
        ),
        ViewsToolbox.emptySpaceWidget(width: 4),
        Text(
          TR.of(context).promotion,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.w400, color: Color(0xFF272727)), //TODO: change later
        ),
      ],
    );
  }

  Widget promotionDate(BuildContext context, PromotionDetailsViewModel vm) {
    return Row(
      children: <Widget>[
        startDate(context, vm),
        ViewsToolbox.emptySpaceWidget(width: 16),
        endDate(context, vm),
      ],
    );
  }

  Widget startDate(BuildContext context, PromotionDetailsViewModel vm) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              TR.of(context).start_date,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              DateTimeManager.convertDateTimeToAppFormat(vm.promotion.fromDate),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget endDate(BuildContext context, PromotionDetailsViewModel vm) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              TR.of(context).end_date,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              DateTimeManager.convertDateTimeToAppFormat(vm.promotion.toDate),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
