part of animated_items;

class ScaleItem extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  final Duration? delay;
  final double scale;
  final Curve curve;
  const ScaleItem({
    Key? key,
    this.duration,
    this.delay,
    required this.child,
    this.scale = 0,
    this.curve = Curves.easeInCubic,
  }) : super(key: key);

  static Widget index({
    Key? key,
    Duration? duration,
    Duration? delay,
    required Widget child,
    required int index,
    final Curve curve = Curves.easeInCubic,
    double scale = 0,
    bool? firstBuild,
  }) =>
      Builder(
        builder: (BuildContext context) {
          return AnimatedItemConfig(
            index: index,
            firstBuild:
                firstBuild ?? CompleteList.of(context)?.firstBuild ?? false,
            child: ScaleItem(
              key: key,
              curve: curve,
              delay: delay,
              duration: duration,
              scale: scale,
              child: child,
            ),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    var _duration = duration ?? Duration(milliseconds: 400);
    var config = AnimatedItemConfig.of(context);
    return AnimatedItem(
      duration: _duration,
      delay: delay ??
          Duration(
              milliseconds: config?.firstBuild == true
                  ? ((_duration.inMilliseconds / 2) * config!.index).toInt()
                  : 0),
      curve: curve,
      builder: (t) {
        return Transform.scale(
          scale: scale + (1 - scale) * t,
          child: child,
        );
      },
    );
  }
}
