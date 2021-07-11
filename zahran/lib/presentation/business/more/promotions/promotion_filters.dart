import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

typedef ChangePromotionFilterCallback = void Function({required PromotionStatus currentPromotionsFilter});

class PromotionsFilters extends StatefulWidget {
  final ChangePromotionFilterCallback changePromotionFilter;
  final PromotionStatus selectedPromotionFilter;

  PromotionsFilters({required this.changePromotionFilter, required this.selectedPromotionFilter});

  @override
  _PromotionsFiltersState createState() => _PromotionsFiltersState();
}

class _PromotionsFiltersState extends State<PromotionsFilters> {
  PromotionStatus selectedPromotionFilter = PromotionStatus.ALL;

  @override
  void initState() {
    selectedPromotionFilter = widget.selectedPromotionFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20, start: 16, end: 16, bottom: 10),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () => onPromotionFilterChanged(PromotionStatus.ALL),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: getBackgroundColor(PromotionStatus.ALL),
                ),
                child: Center(
                  child: Text(
                    TR.of(context).all,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: getTextColor(PromotionStatus.ALL),
                        ),
                  ),
                ),
              ),
            ),
          ),
          ViewsToolbox.emptySpaceWidget(width: 16),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () => onPromotionFilterChanged(PromotionStatus.ACTIVE),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: getBackgroundColor(PromotionStatus.ACTIVE),
                ),
                child: Center(
                  child: Text(
                    TR.of(context).active,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: getTextColor(PromotionStatus.ACTIVE),
                        ),
                  ),
                ),
              ),
            ),
          ),
          ViewsToolbox.emptySpaceWidget(width: 16),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () => onPromotionFilterChanged(PromotionStatus.EXPIRED),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: getBackgroundColor(PromotionStatus.EXPIRED),
                ),
                child: Center(
                  child: Text(
                    TR.of(context).expired,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: getTextColor(PromotionStatus.EXPIRED),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getBackgroundColor(PromotionStatus currentPromotionsFilter) {
    return selectedPromotionFilter == currentPromotionsFilter
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.surface;
  }

  Color getTextColor(PromotionStatus currentPromotionsFilter) {
    return selectedPromotionFilter == currentPromotionsFilter
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.primary;
  }

  void onPromotionFilterChanged(PromotionStatus currentPromotionsFilter) {
    setState(() {
      selectedPromotionFilter = currentPromotionsFilter;
    });
    widget.changePromotionFilter(currentPromotionsFilter: currentPromotionsFilter);
  }
}
