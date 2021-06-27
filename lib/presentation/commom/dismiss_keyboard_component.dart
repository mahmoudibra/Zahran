import 'package:flutter/material.dart';

class KeyboardDismissWidget extends StatelessWidget {
  final Widget _child;
  final VoidCallback _callback;

  KeyboardDismissWidget({@required Widget child, VoidCallback callback})
      : this._child = child,
        this._callback = callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_callback != null) _callback();
      },
      child: _child,
    );
  }
}
