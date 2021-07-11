import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/scaffold_list_silver_app_bar.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'brand_list.row.dart';
import 'brand_view_model.dart';

class BrandsListScreen extends StatelessWidget {
  const BrandsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BrandListViewModel(context),
        builder: (BrandListViewModel vm) {
          return ScaffoldListSilverAppBar(
            content: buildBranchList(context, vm),
            title: TR.of(context).brand_product,
          );
        });
  }

  Widget buildBranchList(BuildContext context, BrandListViewModel vm) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      padding: EdgeInsets.all(0).copyWith(top: 0),
      builItem: (BrandModel item, index) {
        return FadeItem(
            child: BrandRow(
          brand: item,
        ));
      },
      init: vm,
    );
  }
}
