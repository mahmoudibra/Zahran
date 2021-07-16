import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/prefered_size_title.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'sallaries_view_model.dart';
import 'sallary_view.dart';

class SallariesScreen extends StatefulWidget {
  const SallariesScreen({Key? key}) : super(key: key);

  @override
  _SallariesScreenState createState() => _SallariesScreenState();
}

class _SallariesScreenState extends State<SallariesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompleteList.sliversWithList(
        init: SallariesViewModel(),
        enablePullUp: false,
        headers: (SallariesViewModel ctrl) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            floating: true,
            pinned: true,
            bottom: PreferedSizeTitle(
              title: TR.of(context).sallary_slip,
              search: Search(
                enabled: !ctrl.loading,
                intialValue: ctrl.query,
                onChanged: ctrl.search,
                title: TR.of(context).search_month,
              ),
            ),
          ),
        ],
        footers: (SallariesViewModel ctrl) => ctrl.loading
            ? []
            : [
                SliverFillRemaining(
                  fillOverscroll: true,
                  hasScrollBody: false,
                ),
                SliverSpacer()
              ],
        itemShimmer: ShimmerEffect(builder: () => SallaryShimmer()),
        padding: EdgeInsets.all(20).copyWith(top: 10),
        filterItems: (SallariesViewModel ctrl) => ctrl.filtered,
        builItem: (SallaryModel item, index) {
          return ScaleItem(
            child: SallaryView(model: item),
          );
        },
      ),
    );
  }
}
