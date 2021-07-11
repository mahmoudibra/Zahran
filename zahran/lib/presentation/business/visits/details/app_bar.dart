import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/r.dart';

import 'map_view.dart';
import 'visit_details_view_model.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BranchModel model = Get.find<VisitDetailsViewModel>().model;
    if (model.visitStatus != VisitStatus.PENDING)
      return SliverAppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: AssetIcon(R.assetsImagesCallIcon),
          )
        ],
      );
    var h = MediaQuery.of(context).size.height;
    return SliverAppBar(
      expandedHeight: h * 0.3,
      actions: [
        IconButton(
          onPressed: () {},
          icon: AssetIcon(R.assetsImagesCallIcon),
        )
      ],
      pinned: true,
      elevation: 0,
      flexibleSpace: Builder(
        builder: (BuildContext context) {
          var theme = Theme.of(context).bottomSheetTheme;
          var percent = context.appBarExpansionPercent;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: h * 0.3,
                child: MapView(),
              ),
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.15),
                ),
              ),
              Positioned(
                bottom: -2,
                right: 0,
                left: 0,
                height: 26 + kToolbarHeight * percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: (theme.shape as RoundedRectangleBorder)
                        .borderRadius
                        .subtract(BorderRadius.only(
                          topLeft: Radius.circular(24 * percent),
                          topRight: Radius.circular(24 * percent),
                        )),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
