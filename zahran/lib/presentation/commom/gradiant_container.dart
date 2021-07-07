import 'package:flutter/material.dart';

class GradiantContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double alpha;
  const GradiantContainer(
      {Key key,
      @required this.child,
      this.alpha = 1,
      this.padding,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return Container(
      child: child,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.primary.withOpacity(alpha),
            colors.primaryVariant.withOpacity(alpha)
          ],
        ),
      ),
    );
  }
}
