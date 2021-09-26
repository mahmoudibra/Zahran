import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../../../../r.dart';

class VisitReportsSheet extends StatelessWidget {
  const VisitReportsSheet({Key? key}) : super(key: key);
  static Future show(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return VisitReportsSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitDetailsViewModel>(
        builder: (VisitDetailsViewModel vm) {
      return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        child: ListTileTheme(
          dense: true,
          child: ListView(
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              Text(TR.of(context).select_report_option,
                  style: context.headline6),
              SizedBox(height: 10),
              ...ListTile.divideTiles(
                color: Theme.of(context).dividerColor,
                tiles: [
                  _buildItem(
                    context: context,
                    label: TR.of(context).comment,
                    icon: R.assetsImgsComment,
                    disabled: vm.model.comment,
                    onTap: () {
                      ScreenNames.COMMENT_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).problem,
                    icon: R.assetsImgsProblem,
                    disabled: false,
                    onTap: () {
                      ScreenNames.PROBLEM_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).competition_sell_out,
                    icon: R.assetsImgsCompetetion,
                    disabled: vm.model.competitionSellOut,
                    onTap: () {
                      ScreenNames.COMPITION_SELL_OUT_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).competition_stock_count,
                    icon: R.assetsImgsCompetetion,
                    disabled: vm.model.competitionStockCount,
                    onTap: () {
                      ScreenNames.COMPITION_STOCK_COUNT_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).sell_out,
                    icon: R.assetsImgsSellOut,
                    disabled: vm.model.sellOut,
                    onTap: () {
                      ScreenNames.SELL_OUT_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).stock_count,
                    icon: R.assetsImgsStockCount,
                    disabled: vm.model.stockCount,
                    onTap: () {
                      ScreenNames.STOCK_COUNT_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).return_report,
                    icon: R.assetsImgsReturn,
                    disabled: vm.model.returnReport,
                    onTap: () {
                      ScreenNames.RETURN_REPORT.push();
                    },
                  ),
                  _buildItem(
                    context: context,
                    label: TR.of(context).supply,
                    icon: R.assetsImgsSupplyOrder,
                    disabled: vm.model.supplyOrder,
                    onTap: () {
                      ScreenNames.SUPPLY_REPORT.push();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildItem({
    required BuildContext context,
    required String label,
    required String icon,
    required VoidCallback onTap,
    required bool disabled,
  }) {
    return ListTile(
      enabled: !disabled,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: AssetIcon(
        icon,
      ),
      trailing: AssetIcon(R.assetsImagesArrowRight, color: Colors.grey),
      horizontalTitleGap: 0,
      title: Text(
        label,
        style: context.bodyText1?.copyWith(
          color: disabled ? Theme.of(context).disabledColor : null,
        ),
      ),
    );
  }
}
