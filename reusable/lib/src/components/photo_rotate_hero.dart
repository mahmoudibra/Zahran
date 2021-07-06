import 'dart:math';

import 'package:flutter/material.dart';

class PhotoRotateHero extends StatelessWidget {
  final String tag;
  final Widget child;

  const PhotoRotateHero({Key? key, required this.tag, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final toHero = toHeroContext.widget as Hero;
        return flightDirection == HeroFlightDirection.push
            ? RotationTransition(
                turns: animation,
                child: toHero.child,
              )
            : FadeTransition(
                opacity: animation.drive(
                  Tween<double>(begin: 0.0, end: 1.0).chain(
                    CurveTween(
                      curve: Interval(0.0, 1.0, curve: ValleyQuadraticCurve()),
                    ),
                  ),
                ),
                child: toHero.child,
              );
      },
      child: child,
    );
  }
}

class ValleyQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return (4 * pow(t - 0.5, 2)).toDouble();
  }
}
