import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/rounded_image.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/helpers/date/date-manager.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'PromotionStatus.dart';

class PromotionRow extends StatelessWidget {
  final VoidCallback onPromotionClicked;
  final Promotion promotion;

  PromotionRow({required this.onPromotionClicked, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPromotionClicked,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsetsDirectional.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            promotionImage(context),
            ViewsToolbox.emptySpaceWidget(height: 6),
            promotionTitle(context),
            ViewsToolbox.emptySpaceWidget(height: 8),
            promotionDate(context),
            ViewsToolbox.emptySpaceWidget(height: 16),
            promotionStatus(context),
            ViewsToolbox.emptySpaceWidget(height: 10),
          ],
        ),
      ),
    );
  }

  Widget promotionImage(BuildContext context) {
    return ShapedRemoteImage(
      url: promotion.cover,
      height: 104,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
    );
  }

  Widget promotionTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16),
      child: Text(
        promotion.title.format(context),
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget promotionDate(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16),
      child: Row(
        children: <Widget>[
          startDate(context),
          endDate(context),
        ],
      ),
    );
  }

  Widget startDate(BuildContext context) {
    return Expanded(
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
            DateTimeManager.convertDateTimeToAppWithoutHours(
                promotion.fromDate),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget endDate(BuildContext context) {
    return Expanded(
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
            DateTimeManager.convertDateTimeToAppWithoutHours(promotion.toDate),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget promotionStatus(BuildContext context) {
    var product = promotion.products.isEmpty ? null : promotion.products.first;
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16),
      child: Row(
        children: <Widget>[
          RoundedImage(
            radius: 20,
            borderSize: 1,
            imageUrl: product?.media ?? "",
            borderColor: Theme.of(context).dividerColor,
            loadingIndicatorSize: 10,
          ),
          ViewsToolbox.emptySpaceWidget(width: 8),
          Expanded(
            child: Text(
              product?.name.format(context) ?? "",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.headline1?.color,
                  ),
            ),
          ),
          PromotionStatusWidget(
            promotionStatus: promotion.status,
          )
        ],
      ),
    );
  }
}
