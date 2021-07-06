import 'package:flutter/material.dart';

class TabControllerLisner extends StatefulWidget {
  final TabController? controller;
  final Widget Function(int index) builder;
  const TabControllerLisner({
    Key? key,
    this.controller,
    required this.builder,
  }) : super(key: key);
  @override
  _TabControllerLisnerState createState() => _TabControllerLisnerState();
}

class _TabControllerLisnerState extends State<TabControllerLisner> {
  TabController? _controller;

  void _onIndexChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(TabControllerLisner oldWidget) {
    _controller?.removeListener(_onIndexChanged);
    _controller?.addListener(_onIndexChanged);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _controller?.removeListener(_onIndexChanged);
    _controller = widget.controller ?? DefaultTabController.of(context);
    _controller?.addListener(_onIndexChanged);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller?.index ?? 0);
  }
}
