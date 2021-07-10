import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/profile_tab/profile_tab_app_bar.dart';
import 'package:zahran/presentation/business/visits/visits_app_bar.dart';
import 'package:zahran/presentation/commom/gradient_container.dart';

class HomeAppBar extends StatefulWidget {
  final bool innerBoxIsScrolled;
  const HomeAppBar({Key? key, required this.innerBoxIsScrolled})
      : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _expandedHeight;
  late Animation<double> _radius;
  late TabController _controller;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _expandedHeight = Tween(
      begin: expandedHeight(0),
      end: expandedHeight(1),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeInCubic),
    ));
    _radius = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.5, 1, curve: Curves.easeInCubic),
    ));
    super.initState();
  }

  void change() {
    if (_controller.index == 0)
      controller.reverse();
    else
      controller.forward();
  }

  @override
  void didChangeDependencies() {
    _controller = DefaultTabController.of(context)!;
    _controller.addListener(change);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeListener(change);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        var index = _controller.index;
        return SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
          brightness: Brightness.dark,
          expandedHeight: _expandedHeight.value,
          forceElevated: widget.innerBoxIsScrolled,
          flexibleSpace: Builder(
            builder: (context) {
              var t = context.appBarExpansionPercent;
              var theme = Theme.of(context).bottomSheetTheme;
              var nt = 1 - t;
              return GradientContainer(
                colors: (index == 1).onTrue([
                  Color(0xFF0A063D),
                  Color(0xFF02001E),
                ]),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 26 * _radius.value),
                      child: buildChild(nt, index),
                    ),
                    radius(context, theme),
                  ],
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

  Positioned radius(BuildContext context, BottomSheetThemeData theme) {
    return Positioned(
      bottom: -2,
      right: 0,
      left: 0,
      child: Container(
        height: 26 * _radius.value,
        decoration: BoxDecoration(
          color: theme.backgroundColor?.withOpacity(_radius.value),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26 * _radius.value),
            topRight: Radius.circular(26 * _radius.value),
          ),
        ),
      ),
    );
  }

  double expandedHeight(int i) {
    if (i == 0)
      return kToolbarHeight * 2;
    else
      return kToolbarHeight * 5;
  }

  Widget buildChild(double expansion, int index) {
    if (index == 0)
      return VisitsAppBar(expansion: expansion);
    else
      return ProfileTabsAppBar(expansion: expansion);
  }
}
