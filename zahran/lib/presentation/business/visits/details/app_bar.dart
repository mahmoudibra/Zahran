import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/r.dart';
import 'package:reusable/reusable.dart';
import 'map_view.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return SliverAppBar(
      //backgroundColor: Colors.transparent,
      brightness: Brightness.light,
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
              MapView(),
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
                    borderRadius:
                        (theme.shape as RoundedRectangleBorder).borderRadius,
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
