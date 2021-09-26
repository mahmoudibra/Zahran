import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';

import 'report_list_view_model.dart';
import 'report_shimmer.dart';
import 'report_view.dart';

class ReportListTab extends StatelessWidget {
  final String type;
  const ReportListTab({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      tag: type,
      shrinkWrap: (_) => true,
      headers: (ctrl) => [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
      ],
      itemShimmer: ShimmerEffect(
        builder: () => ReportShimmer(),
      ),
      padding: EdgeInsets.all(20).copyWith(top: 10),
      builItem: (BranchReport item, index) {
        return FadeItem(child: ReportView(model: item));
      },
      init: ReportListViewModel(context, type),
    );
  }
}
