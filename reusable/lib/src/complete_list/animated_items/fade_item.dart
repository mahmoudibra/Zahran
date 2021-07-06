part of animated_items;

class FadeItem extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  const FadeItem({
    Key? key,
    this.duration,
    this.delay,
    required this.child,
    this.curve = Curves.easeInCubic,
  }) : super(key: key);

  static Widget index({
    Key? key,
    Duration? duration,
    Duration? delay,
    required Widget child,
    required int index,
    Curve curve = Curves.easeInCubic,
    bool? firstBuild,
  }) =>
      Builder(
        builder: (BuildContext context) {
          return AnimatedItemConfig(
            index: index,
            firstBuild:
                firstBuild ?? CompleteList.of(context)?.firstBuild ?? false,
            child: FadeItem(
              key: key,
              curve: curve,
              duration: duration,
              delay: delay,
              child: child,
            ),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return AnimatedItem(
      duration: duration,
      delay: delay,
      curve: curve,
      builder: (t) {
        return Opacity(
          opacity: t,
          child: child,
        );
      },
    );
  }
}
