import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/counter.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';
import 'package:zahran/r.dart';

class ReportView extends StatelessWidget {
  final BranchReport model;
  const ReportView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          ScreenNames.BRANCH_REPORTS_SCREEN.push(model);
        },
        child: _build(context),
      ),
    );
  }

  Column _build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _firstRow(context),
              SizedBox(height: 10),
              _secondRow(context),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              _thirdRow(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _firstRow(BuildContext context) {
    return Text(model.branch.name.format(context), style: context.headline6);
  }

  Widget _thirdRow(BuildContext context) {
    return CounterView(
      value: model.reportCount,
      label: TR.of(context).report,
    );
  }

  Row _secondRow(BuildContext context) {
    return Row(
      children: [
        AssetIcon(R.assetsImgsInRange, size: 16),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            model.branch.address.format(context),
            style: context.overline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 5),
        Text(TR.of(context).distance_away(model.branch.distance.noTrailing()),
            style: context.overline)
      ],
    );
  }
}
