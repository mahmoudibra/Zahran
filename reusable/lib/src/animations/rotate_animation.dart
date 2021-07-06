import 'package:flutter/material.dart';

class RotateAnimation extends ImplicitlyAnimatedWidget {
  final Widget child;
  final double angle;
  RotateAnimation({
    Key? key,
    required this.child,
    required this.angle,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(key: key, duration: duration, curve: curve, onEnd: onEnd);

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
}

class _RotateAnimationState
    extends ImplicitlyAnimatedWidgetState<RotateAnimation> {
  Tween<double>? _angle;
  Animation<double>? _angleAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _angle = visitor(_angle, widget.angle,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
  }

  @override
  void didUpdateTweens() {
    if (_angle != null) _angleAnimation = animation.drive(_angle!);
  }

  @override
  Widget build(BuildContext context) {
    if (_angleAnimation == null) return widget.child;
    return AnimatedBuilder(
        animation: _angleAnimation!,
        builder: (context, snapshot) {
          return Transform.rotate(
            angle: _angleAnimation!.value,
            child: widget.child,
          );
        });
  }
}
