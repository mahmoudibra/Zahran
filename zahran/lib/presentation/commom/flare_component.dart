import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FlareAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlareActor(
      "assets/animations/loading.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: "shuffle",
      color: Theme.of(context).primaryColor,
    );
  }
}
