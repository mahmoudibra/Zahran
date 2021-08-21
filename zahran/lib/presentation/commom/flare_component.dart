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

  static Future<TType> show<TType>({required Future<TType> action, required BuildContext context}) async {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (_) => AbsorbPointer(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 60,
            width: 60,
            child: FlareAnimation(),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    try {
      var value = await action;
      Navigator.of(context).pop();
      return Future.value(value);
    } catch (error) {
      Navigator.of(context).pop();
      return Future.error(error);
    }
  }

  static hide({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
