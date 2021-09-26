import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'branch_report_list_view_model.dart';
import 'report_shimmer.dart';
import 'report_view.dart';

class BranchReportListScreen extends StatelessWidget {
  const BranchReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompleteList.sliversWithList(
        enablePullUp: false,
        shrinkWrap: (_) => true,
        headers: (ctrl) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                height: kToolbarHeight,
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  TR.of(context).reports,
                  style: context.headline2,
                ),
              ),
            ),
          )
        ],
        itemShimmer: ShimmerEffect(
          builder: () => ReportShimmer(),
        ),
        padding: EdgeInsets.all(20).copyWith(top: 10),
        builItem: (ReportModel item, index) {
          return FadeItem(child: ReportView(model: item));
        },
        init: BranchReportListViewModel(context),
      ),
    );
  }
}
