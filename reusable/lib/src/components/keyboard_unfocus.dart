import 'package:flutter/material.dart';

class KeyBoadUnfocusAction extends StatefulWidget {
  final Widget child;
  const KeyBoadUnfocusAction({required this.child});

  @override
  _KeyBoadUnfocusActionState createState() => _KeyBoadUnfocusActionState();
}

class _KeyBoadUnfocusActionState extends State<KeyBoadUnfocusAction>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: widget.child,
    );
  }
}
