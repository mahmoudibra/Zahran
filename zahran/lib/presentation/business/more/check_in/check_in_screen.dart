import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/more/check_in/check_in_view_model.dart';
import 'package:zahran/presentation/commom/prefered_size_title.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'check_in_view.dart';

class CheckINScreen extends StatefulWidget {
  const CheckINScreen({Key? key}) : super(key: key);

  @override
  _CheckINScreenState createState() => _CheckINScreenState();
}

class _CheckINScreenState extends State<CheckINScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompleteList.sliversWithList(
        init: CheckInListViewModel(context),
        enablePullUp: false,
        headers: (CheckInListViewModel ctrl) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            floating: true,
            pinned: true,
            bottom: PreferedSizeTitle(
              title: TR.of(context).check_in_list,
              search: Search(
                enabled: !ctrl.loading,
                intialValue: ctrl.query,
                onChanged: ctrl.search,
                title: TR.of(context).check_in_search,
              ),
            ),
          ),
        ],
        footers: (CheckInListViewModel ctrl) => ctrl.loading
            ? []
            : [
                SliverFillRemaining(
                  fillOverscroll: true,
                  hasScrollBody: false,
                ),
                SliverSpacer()
              ],
        itemShimmer: ShimmerEffect(builder: () => CheckInShimmer()),
        padding: EdgeInsets.all(20).copyWith(top: 10),
        filterItems: (CheckInListViewModel ctrl) => ctrl.filtered,
        builItem: (BranchModel item, index) {
          return FadeItem(
            child: CheckINView(
              model: item,
              onCheckInSelectedCallback: () {
                ScreenNames.VISIT_DETAILS.push(item);
              },
            ),
          );
        },
      ),
    );
  }
}
