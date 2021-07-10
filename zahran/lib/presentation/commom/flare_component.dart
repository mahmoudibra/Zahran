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

  static Future<TType> show<TType>(
      {required Future<TType> action, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          height: 60,
          width: 60,
          child: FlareAnimation(),
        ),
      ),
      barrierDismissible: false,
    );
    return action.then((value) {
      Navigator.of(context).pop();
      return value;
    }).catchError((e) {
      Navigator.of(context).pop();
      throw e;
    });
  }
}
