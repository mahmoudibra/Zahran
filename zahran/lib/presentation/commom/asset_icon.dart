import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String name;
  final Color? color;
  final double? size;
  const AssetIcon(this.name, {this.color, this.size});

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    return Image.asset(
      name,
      width: size ?? iconTheme.size,
      height: size ?? iconTheme.size,
      color: color,
    );
  }
}
