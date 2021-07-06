part of animated_items;

class FlipSlideFadeItem extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final Offset Function(BoxConstraints constraints)? offset;
  final Curve curve;
  final FractionalOffset? alignment;
  const FlipSlideFadeItem({
    Key? key,
    this.duration,
    this.delay,
    required this.child,
    this.curve = Curves.easeInCubic,
    this.offset,
    this.alignment,
  }) : super(key: key);
  static const double degrees2Radians = pi / 180;
  static Widget index({
    Key? key,
    Duration? duration,
    Duration? delay,
    required Widget child,
    required int index,
    Curve curve = Curves.easeInCubic,
    FractionalOffset? alignment,
    Offset Function(BoxConstraints constraints)? offset,
    bool? firstBuild,
  }) =>
      Builder(
        builder: (BuildContext context) {
          return AnimatedItemConfig(
            index: index,
            firstBuild:
                firstBuild ?? CompleteList.of(context)?.firstBuild ?? false,
            child: FlipSlideFadeItem(
              key: key,
              curve: curve,
              duration: duration,
              delay: delay,
              alignment: alignment,
              offset: offset,
              child: child,
            ),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var width = (constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.width
            : constraints.maxWidth);
        var _offset = offset == null ? Offset(width, 0) : offset!(constraints);

        return AnimatedItem(
          duration: duration,
          delay: delay,
          curve: curve,
          builder: (t) {
            return Opacity(
              opacity: 1,
              child: Transform(
                alignment: alignment ?? FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    _offset.dx * (1 - t),
                    _offset.dy * (1 - t),
                  )
                  ..rotateY((180 - 180 * t) * degrees2Radians),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
