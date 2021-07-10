import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String name;
  final Color? color;
  const AssetIcon(this.name, {this.color});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(name),
      color: color,
    );
  }
}
