part of helpers;

class WidgetAnimations<T> {
  final Widget widget;
  final Animation<T> forward;
  final Animation<T> reverse;

  WidgetAnimations({
    required this.widget,
    required this.forward,
    required this.reverse,
  });

  static List<WidgetAnimations<S>> createList<S>({
    required List<Widget> widgets,
    required AnimationController controller,
    Cubic forwardCurve = Curves.ease,
    Cubic reverseCurve = Curves.ease,
    required S begin,
    required S end,
  }) {
    final animations = <WidgetAnimations<S>>[];

    var start = 0.0;
    final duration = 1.0 / (widgets.length * 2);
    widgets.forEach((childWidget) {
      final animation = Tween<S>(
        begin: begin,
        end: end,
      ).animate(
        CurvedAnimation(
          curve: Interval(start, start + duration, curve: Curves.ease),
          parent: controller,
        ),
      );

      final revAnimation = Tween<S>(
        begin: end,
        end: begin,
      ).animate(
        CurvedAnimation(
          curve: Interval(start + duration, start + duration * 2,
              curve: Curves.ease),
          parent: controller,
        ),
      );

      animations.add(WidgetAnimations(
        widget: childWidget,
        forward: animation,
        reverse: revAnimation,
      ));

      start += duration;
    });

    return animations;
  }
}
