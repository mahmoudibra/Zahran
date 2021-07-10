import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String name;
  final Color? color;
  const AssetIcon(this.name, {this.color});

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    return Image.asset(
      name,
      width: iconTheme.size,
      height: iconTheme.size,
      color: color,
    );
  }
}
