import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/brands_view.dart';
import 'package:zahran/presentation/commom/counter.dart';
import 'package:zahran/presentation/commom/progress_gradiant.dart';
import 'package:zahran/presentation/commom/visit_status_chip.component.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';
import 'package:zahran/r.dart';

class VisitView extends StatelessWidget {
  final BranchModel model;
  const VisitView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          ScreenNames.VISIT_DETAILS.push(model);
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
              Divider(),
              _thirdRow(context, model.brands),
            ],
          ),
        ),
        if (model.visitStatus == VisitStatus.IN_PROGRESS)
          ProgressGradiant(progress: model.completedTasks / model.totalTasks),
      ],
    );
  }

  Row _firstRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(model.name.format(context), style: context.headline6),
        ),
        if (model.visitStatus != VisitStatus.PENDING) ...[
          SizedBox(width: 10),
          VisitStatusChip(visitStatus: model.visitStatus),
        ]
      ],
    );
  }

  int getTasks() {
    if (model.visitStatus.isInProgress || model.visitStatus.isCompleted)
      return model.completedTasks;
    if (model.visitStatus.isIncomplete) return model.incompletedTasks;
    return model.totalTasks;
  }

  Widget _thirdRow(BuildContext context, List<BrandModel> brands) {
    return Row(
      children: [
        CounterView(
          value: getTasks(),
          of: model.visitStatus == VisitStatus.IN_PROGRESS
              ? model.totalTasks
              : null,
          label: TR.of(context).tasksLabel(getTasks()),
        ),
        SizedBox(width: 10),
        Expanded(
          child: BrandsView(brands: brands, reversed: true),
        ),
      ],
    );
  }

  Row _secondRow(BuildContext context) {
    return Row(
      children: [
        AssetIcon(R.assetsImgsInRange, size: 16),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            model.address.format(context),
            style: context.overline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 5),
        Text(TR.of(context).distance_away(model.distance.noTrailing()),
            style: context.overline)
      ],
    );
  }
}
