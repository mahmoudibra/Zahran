import 'package:flutter/material.dart';

class ScafoldWithBottomSheet extends StatefulWidget {
  final Widget Function(ScrollController controller, double offset) bottom;
  final Widget Function(double offset) body;
  final Color? background;
  const ScafoldWithBottomSheet({
    Key? key,
    required this.bottom,
    required this.body,
    this.background,
  }) : super(key: key);

  @override
  _ScafoldWithBottomSheetState createState() => _ScafoldWithBottomSheetState();
}

class _ScafoldWithBottomSheetState extends State<ScafoldWithBottomSheet> {
  double offset = 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.background,
      body: widget.body(offset),
      bottomSheet: NotificationListener(
        onNotification: (DraggableScrollableNotification scrollInfo) {
          setState(() {
            offset = scrollInfo.extent;
          });
          return false;
        },
        child: DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.6,
          initialChildSize: 0.6,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return widget.bottom(scrollController, offset);
          },
        ),
      ),
    );
  }
}
