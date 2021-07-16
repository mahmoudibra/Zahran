import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/prefered_size_title.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'salaries_view_model.dart';
import 'salary_view.dart';

class SalariesScreen extends StatefulWidget {
  const SalariesScreen({Key? key}) : super(key: key);

  @override
  _SalariesScreenState createState() => _SalariesScreenState();
}

class _SalariesScreenState extends State<SalariesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompleteList.sliversWithList(
        init: SalariesViewModel(),
        enablePullUp: false,
        headers: (SalariesViewModel ctrl) => [
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
        footers: (SalariesViewModel ctrl) => ctrl.loading
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
        filterItems: (SalariesViewModel ctrl) => ctrl.filtered,
        builItem: (SalaryModel item, index) {
          return ScaleItem(
            child: SalaryView(model: item),
          );
        },
      ),
    );
  }
}
