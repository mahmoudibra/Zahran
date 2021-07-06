import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final double widgetRadius;

  AppShimmer({@required this.child, this.widgetRadius = 0.0});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(4),
      color: Colors.transparent,
      child: Shimmer.fromColors(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.all(Radius.circular(widgetRadius))),
          child: child,
        ),
        baseColor: _getBaseColor(context),
        highlightColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Color _getBaseColor(BuildContext context) {
    return Colors.amber;
    //TODO: uncomment this later
    // return Theme.of(context).brightness == Brightness.light
    //     ? TinyColor(Theme.of(context).scaffoldBackgroundColor).darken(8).color
    //     : TinyColor(Theme.of(context).scaffoldBackgroundColor).lighten(8).color;
  }
}
