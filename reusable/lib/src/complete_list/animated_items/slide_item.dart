part of animated_items;

class SlideItem extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final Offset Function(BoxConstraints constraints)? offset;
  final Curve curve;
  const SlideItem({
    Key? key,
    this.duration,
    this.delay,
    required this.child,
    this.offset,
    this.curve = Curves.easeInCubic,
  }) : super(key: key);

  static Widget index({
    Key? key,
    Duration? duration,
    Duration? delay,
    required Widget child,
    required int index,
    final Curve curve = Curves.easeInCubic,
    Offset Function(BoxConstraints constraints)? offset,
    bool? firstBuild,
  }) =>
      Builder(
        builder: (BuildContext context) {
          return AnimatedItemConfig(
            index: index,
            firstBuild:
                firstBuild ?? CompleteList.of(context)?.firstBuild ?? false,
            child: SlideItem(
              key: key,
              curve: curve,
              delay: delay,
              duration: duration,
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
            return Transform.translate(
              offset: Offset(_offset.dx * (1 - t), _offset.dy * (1 - t)),
              child: child,
            );
          },
        );
      },
    );
  }
}
