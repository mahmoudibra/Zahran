import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';
import 'package:zahran/r.dart';

import 'report_details_view_model.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Get.find<ReportDetailsViewModel>();
    ReportModel model = vm.model;
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      bottom: PreferredSize(
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 20, end: 4),
          height: kToolbarHeight,
          alignment: Alignment.topCenter,
          child: ShimmerView(
            loading: vm.loading,
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    getName(context, model),
                    maxLines: 1,
                    style: context.headline2,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    getScreen(context, model).push(model);
                  },
                  icon: AssetIcon(R.assetsImgsEdit),
                )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
    );
  }

  String getName(BuildContext context, ReportModel model) {
    switch (model.type) {
      case ReportTypes.Comment:
        return TR.of(context).comment;
      case ReportTypes.Problem:
        return TR.of(context).problem;
      case ReportTypes.Competition_Sell_OUT:
        return TR.of(context).competition_sell_out;
      case ReportTypes.Competition_Stock_Count:
        return TR.of(context).competition_stock_count;
      case ReportTypes.Sell_OUT:
        return TR.of(context).sell_out;
      case ReportTypes.Stock_Count:
        return TR.of(context).stock_count;
      case ReportTypes.Return_Report:
        return TR.of(context).return_report;
      case ReportTypes.Supply_Order:
        return TR.of(context).supply;
    }
  }

  ScreenNames getScreen(BuildContext context, ReportModel model) {
    switch (model.type) {
      case ReportTypes.Comment:
        return ScreenNames.COMMENT_REPORT;
      case ReportTypes.Problem:
        return ScreenNames.PROBLEM_REPORT;
      case ReportTypes.Competition_Sell_OUT:
        return ScreenNames.COMPITION_SELL_OUT_REPORT;
      case ReportTypes.Competition_Stock_Count:
        return ScreenNames.COMPITION_STOCK_COUNT_REPORT;
      case ReportTypes.Sell_OUT:
        return ScreenNames.SELL_OUT_REPORT;
      case ReportTypes.Stock_Count:
        return ScreenNames.STOCK_COUNT_REPORT;
      case ReportTypes.Return_Report:
        return ScreenNames.RETURN_REPORT;
      case ReportTypes.Supply_Order:
        return ScreenNames.SUPPLY_REPORT;
    }
  }
}
