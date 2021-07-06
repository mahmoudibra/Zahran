import 'package:flutter/material.dart';

class HeroDecoratedBox extends StatelessWidget {
  final Widget child;
  final String tag;
  final Decoration decoration;
  const HeroDecoratedBox({
    Key? key,
    required this.child,
    required this.tag,
    required this.decoration,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (ctx, animation, direction, from, to) {
        var decoratedTo = (to.widget as Hero).child as DecoratedBox;
        var decoratedFrom = (from.widget as Hero).child as DecoratedBox;
        var isPush = (direction == HeroFlightDirection.push);

        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            var value = DecorationTween(
              begin: decoratedFrom.decoration,
              end: decoratedTo.decoration,
            ).transform(isPush ? animation.value : 1 - animation.value);
            Widget? child;
            if (isPush) {
              child = animation.value < 0.4
                  ? decoratedFrom.child
                  : decoratedTo.child;
            } else {
              child = animation.value > 0.6
                  ? decoratedFrom.child
                  : decoratedTo.child;
            }
            return DecoratedBox(
              decoration: value,
              child: child,
            );
          },
        );
      },
      child: DecoratedBox(
        decoration: decoration,
        child: child,
      ),
    );
  }
}
