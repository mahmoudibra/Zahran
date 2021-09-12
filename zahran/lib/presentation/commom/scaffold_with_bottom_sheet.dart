import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:reusable/reusable.dart';

class ScafoldWithBottomSheet extends StatefulWidget {
  final Widget Function(double t) appBar;
  final Widget body;
  final Color? background;
  final double factor;
  const ScafoldWithBottomSheet({
    Key? key,
    required this.appBar,
    required this.body,
    this.background,
    this.factor = 0.3,
  }) : super(key: key);

  @override
  _ScafoldWithBottomSheetState createState() => _ScafoldWithBottomSheetState();
}

class _ScafoldWithBottomSheetState extends State<ScafoldWithBottomSheet> {
  late ScrollController _controller;
  final keyboard = KeyboardVisibilityController();
  late StreamSubscription<bool> _lisner;
  initState() {
    _controller = ScrollController();
    _lisner = keyboard.onChange.listen((bool visible) {
      if (!keyboard.isVisible)
        _controller.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeInCubic);
    });
    super.initState();
  }

  dispose() {
    _controller.dispose();
    _lisner.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context).bottomSheetTheme;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.background,
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: height * widget.factor,
              flexibleSpace: Builder(builder: (context) {
                var t = context.appBarExpansionPercent;
                return ColoredBox(
                  color: Theme.of(context).primaryColor.withOpacity(t),
                  child: SafeArea(
                    bottom: false,
                    child: widget.appBar(t),
                  ),
                );
              }),
              floating: true,
              pinned: true,
            ),
          ];
        },
        body: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: (theme.shape as RoundedRectangleBorder).borderRadius,
          ),
          child: widget.body,
        ),
      ),
    );
  }
}
