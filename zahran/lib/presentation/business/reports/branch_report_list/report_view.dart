import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../../../../../r.dart';

class ReportView extends StatelessWidget {
  final ReportModel model;
  const ReportView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          onTap: () {
            ScreenNames.REPORT_DETAILS.push(model);
          },
          contentPadding: EdgeInsets.zero,
          title: Text(getName(context)),
          trailing: Icon(Icons.navigate_next),
          leading: AssetIcon(getIcon(context)),
        ),
        Divider(height: 1),
      ],
    );
  }

  String getName(BuildContext context) {
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

  String getIcon(BuildContext context) {
    switch (model.type) {
      case ReportTypes.Comment:
        return R.assetsImgsComment;
      case ReportTypes.Problem:
        return R.assetsImgsProblem;
      case ReportTypes.Competition_Sell_OUT:
        return R.assetsImgsCompetetion;
      case ReportTypes.Competition_Stock_Count:
        return R.assetsImgsCompetetion;
      case ReportTypes.Sell_OUT:
        return R.assetsImgsSellOut;
      case ReportTypes.Stock_Count:
        return R.assetsImgsStockCount;
      case ReportTypes.Return_Report:
        return R.assetsImgsReturn;
      case ReportTypes.Supply_Order:
        return R.assetsImgsSupplyOrder;
    }
  }
}
