import 'package:flutter/widgets.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/pop_up/pop_up.component.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class LogoutPopUp extends StatelessWidget {
  final Map<String, dynamic>? _parameters;
  final Map<String, Function>? _actionsCallbacks;

  LogoutPopUp({
    Map<String, dynamic>? parameters,
    Map<String, Function>? actionsCallbacks,
  })  : _parameters = parameters,
        _actionsCallbacks = actionsCallbacks;

  @override
  Widget build(BuildContext context) {
    return PopUp(
      context: context,
      message: TR.of(context).are_you_sure_logout,
      onDismissedAction: () {},
      implicitDismiss: false,
      title: TR.of(context).logout,
      actions: {
        TR.of(context).yes: () async {
          ScreenRouter.pop();
          ScreenNames.SPLASH.pushAndRemoveAll();
          await Get.find<AuthViewModel>().removeUser();
        },
        TR.of(context).no: () async {
          ScreenRouter.pop();
        }
      },
    );
  }
}
