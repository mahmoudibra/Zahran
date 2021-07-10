import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/visits/visits_app_bar.dart';
import 'package:zahran/presentation/commom/gradiant_container.dart';

class HomeAppBar extends StatefulWidget {
  final bool innerBoxIsScrolled;
  const HomeAppBar({Key? key, required this.innerBoxIsScrolled})
      : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabControllerLisner(
      builder: (int index) {
        var expandedHight = expandedHeight(index);
        return SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
          expandedHeight: expandedHight,
          forceElevated: widget.innerBoxIsScrolled,
          flexibleSpace: Builder(
            builder: (context) {
              var t = context.appBarExpansionPercent;
              var nt = 1 - t;
              return GradiantContainer(
                child: AnimatedSize(
                  vsync: this,
                  duration: Duration(milliseconds: 300),
                  child: buildChild(nt, index),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(index == 0 ? 24 * nt : 0),
                  bottomRight: Radius.circular(index == 0 ? 24 * nt : 0),
                ),
              );
            },
          ),
        );
      },
    );
  }

  double expandedHeight(int i) {
    // if (i == 0)
    return kToolbarHeight * 2;
  }

  Widget buildChild(double expansion, int index) {
    // if (index == 0)
    return VisitsAppBar(expansion: expansion);
  }
}
