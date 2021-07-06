import 'package:flutter/material.dart';

class StyleHero extends StatelessWidget {
  final Widget child;
  final String tag;
  final TextStyle? style;
  final HeroFlightShuttleBuilder? flightShuttleBuilder;
  const StyleHero({
    Key? key,
    required this.child,
    required this.tag,
    this.flightShuttleBuilder,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: flightShuttleBuilder ??
          (ctx, animation, direction, from, to) {
            var textTo = (to.widget as Hero).child as DefaultTextStyle;
            var textfrom = (from.widget as Hero).child as DefaultTextStyle;
            var isPush = (direction == HeroFlightDirection.push);

            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? _child) {
                var value = TextStyleTween(
                  begin: textfrom.style,
                  end: textTo.style,
                ).transform(isPush ? animation.value : 1 - animation.value);
                Widget child;
                if (direction == HeroFlightDirection.push) {
                  child = animation.value < 0.4 ? textfrom.child : textTo.child;
                } else {
                  child = animation.value > 0.6 ? textfrom.child : textTo.child;
                }

                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: DefaultTextStyle(
                    key: Key(direction.toString()),
                    style: value,
                    child: child,
                  ),
                );
              },
            );
          },
      child: DefaultTextStyle(
        style: style == null
            ? DefaultTextStyle.of(context).style
            : DefaultTextStyle.of(context).style.merge(style),
        child: child,
      ),
    );
  }
}
