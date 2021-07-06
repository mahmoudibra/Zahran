import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white.withOpacity(0.4),
        alignment: Alignment.center,
        child: Container(
          height: 80.0,
          width: 80.0,
          child: FlareActor(
            "assets/animations/loading.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "shuffle",
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
