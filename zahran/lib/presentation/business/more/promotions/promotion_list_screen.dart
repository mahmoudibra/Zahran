import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_filters.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_row_view.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';
import 'package:zahran/presentation/commom/scaffold_list_silver_app_bar.dart';
import 'package:zahran/presentation/localization/tr.dart';

class PromotionListScreen extends StatelessWidget {
  const PromotionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PromotionViewModel(),
        builder: (PromotionViewModel vm) {
          return ScaffoldListSilverAppBar(
            content: buildPromotionList(context, vm),
            title: TR.of(context).promotions,
          );
        });
  }

  Widget buildPromotionList(BuildContext context, PromotionViewModel vm) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      innerHeaders: (ctrl) => [
        SliverPaddingBox(
          padding:
              EdgeInsetsDirectional.only(start: 0, end: 0, bottom: 0, top: 0),
          child: PromotionsFilters(
              changePromotionFilter: (
                  {required PromotionStatus currentPromotionsFilter}) {
                vm.updateFilterType(currentPromotionsFilter);
              },
              selectedPromotionFilter: vm.selectedFilter),
        ),
      ],
      padding: EdgeInsets.all(0).copyWith(top: 0),
      builItem: (Promotion item, index) {
        return ScaleItem(
            child: PromotionRow(
          promotion: item,
          onPromotionClicked: () {
            vm.routeToPromotionDetails(index);
          },
        ));
      },
      init: vm,
    );
  }
}
