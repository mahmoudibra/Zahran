library animated_items;

import 'dart:math';

import 'package:flutter/material.dart';
import '../complete_list.dart';
part 'slide_fade_item.dart';
part 'fade_item.dart';
part 'scale_item.dart';
part 'slide_item.dart';
part 'flip_item.dart';
part 'flip_slide_item.dart';
part 'flip_slide_fade_item.dart';

class AnimatedItem extends StatefulWidget {
  final Widget Function(double t) builder;
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  const AnimatedItem({
    required this.builder,
    this.duration,
    this.delay,
    required this.curve,
  });
  @override
  _AnimatedItemState createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<AnimatedItem>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var _duration = widget.duration ?? Duration(milliseconds: 400);
    _controller?.dispose();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller!, curve: widget.curve));

    var _delay = widget.delay;
    if (_delay == null) {
      var config = AnimatedItemConfig.of(context);
      if (config != null && config.firstBuild == true) {
        _delay = Duration(
            milliseconds:
                ((_duration.inMilliseconds / 4) * (config.index)).toInt());
      }
    }
    if (_delay != null) {
      Future.delayed(_delay).then((value) {
        if (mounted) _controller?.forward().then((v) {});
      });
    } else {
      _controller?.forward().then((v) {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation!,
        builder: (context, snapshot) {
          return widget.builder(_animation!.value);
        });
  }
}

class AnimatedItemConfig extends StatelessWidget {
  final Widget child;
  final int index;
  final bool firstBuild;
  const AnimatedItemConfig({
    Key? key,
    required this.child,
    required this.index,
    required this.firstBuild,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }

  static AnimatedItemConfig? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<AnimatedItemConfig>();
}
