import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/scaffold_list_silver_app_bar.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'branch_row.dart';
import 'branch_view_model.dart';

class BranchesListScreen extends StatelessWidget {
  const BranchesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BranchListViewModel(),
        builder: (BranchListViewModel vm) {
          return ScaffoldListSilverAppBar(
            content: buildBranchList(context, vm),
            title: TR.of(context).branches,
          );
        });
  }

  Widget buildBranchList(BuildContext context, BranchListViewModel vm) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      padding: EdgeInsets.all(0).copyWith(top: 0),
      builItem: (BranchModel item, index) {
        return FadeItem(
            child: BranchRow(
          branch: item,
          onBranchSelectedCallback: () {
            vm.routeToBranchLocation(index);
          },
        ));
      },
      init: vm,
    );
  }
}
