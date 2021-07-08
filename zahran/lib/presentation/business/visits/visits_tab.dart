import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/visits/visits_view_model.dart';
import 'package:zahran/presentation/localization/ext.dart';

import 'visit_view.dart';

class VisitsTab extends StatelessWidget {
  const VisitsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompleteList.sliversWithList(
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
      ],
      padding: EdgeInsets.all(20),
      builItem: (item, index) {
        return SlideFadeItem(child: VisitView());
      },
      init: VisitsViewModel(),
    );
  }
}
