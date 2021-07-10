import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double alpha;
  final List<Color>? colors;
  const GradientContainer({
    Key? key,
    required this.child,
    this.alpha = 1,
    this.padding,
    this.margin,
    this.borderRadius,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _colors = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: child,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors ??
              [
                _colors.primary.withOpacity(alpha),
                _colors.primaryVariant.withOpacity(alpha)
              ],
        ),
      ),
    );
  }
}
