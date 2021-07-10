import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:zahran/presentation/localization/tr.dart';

class UpdateProfilePageLoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            TR.of(context).personal_info,
            style: Theme.of(context).textTheme.headline4,
          ),
          Expanded(
            child: Center(
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
          )
        ],
      ),
    );
  }
}
