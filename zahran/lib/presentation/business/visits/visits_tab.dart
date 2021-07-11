import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/visits/visits_view_model.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'visit_shimmer.dart';
import 'visit_view.dart';

class VisitsTab extends StatelessWidget {
  const VisitsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      headers: (ctrl) => [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
      ],
      innerHeaders: (ctrl) => [
        SliverSpacer(),
        SliverPaddingBox(
          child: Text(TR.of(context).upcoming_visits, style: context.headline2),
        ),
        SliverPaddingBox(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Chip(
              label: Text(
                DateTime.now()
                    .format(context, DateFormat.yMMMMEEEEd().pattern!),
              ),
            ),
          ),
        ),
      ],
      itemShimmer: ShimmerEffect(
        builder: () => VisitShimmer(),
      ),
      padding: EdgeInsets.all(20).copyWith(top: 10),
      builItem: (BranchModel item, index) {
        return SlideFadeItem(child: VisitView(model: item));
      },
      init: VisitsViewModel(),
    );
  }
}
