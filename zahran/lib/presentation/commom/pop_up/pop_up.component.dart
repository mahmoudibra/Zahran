import 'package:flutter/material.dart';
import 'package:zahran/presentation/localization/tr.dart';

class PopUp extends StatelessWidget {
  final String _title;
  final String _message;
  final Map<String, VoidCallback> _actions;
  final VoidCallback onDismissedAction;

  PopUp({
    required String title,
    required String message,
    Map<String, VoidCallback>? actions,
    required BuildContext context,
    required this.onDismissedAction,
    bool implicitDismiss = true,
  })  : _title = title,
        _message = message,
        _actions = actions ??
            (implicitDismiss
                ? {
                    TR.of(context).generic_pop_up_dismiss_button: () {
                      onDismissedAction();
                      Navigator.of(context).pop();
                    }
                  }
                : {}) {
    if (implicitDismiss) {
      _actions[TR.of(context).generic_pop_up_dismiss_button] = () {
        onDismissedAction();
        Navigator.of(context).pop();
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Text(
        _title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Text(
          _message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Theme.of(context).textTheme.bodyText2?.color),
        ),
      )
    ];

    for (var i = 0; i < _actions.length; i++) {
      items.add(
        Container(
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            height: 48.0,
            child: i == 0
                ? TextButton(
                    onPressed: _actions.entries.elementAt(i).value,
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      _actions.entries.elementAt(i).key,
                      textAlign: TextAlign.center,
                    ))
                : OutlinedButton(
                    onPressed: _actions.entries.elementAt(i).value,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).dividerColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: Text(
                      _actions.entries.elementAt(i).key,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ))),
      );
    }

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 40.0,
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Theme.of(context).dividerColor)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items),
      ),
    );
  }
}
