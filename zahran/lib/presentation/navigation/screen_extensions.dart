part of 'screen_router.dart';

extension RouterExtension on ScreenNames {
  Future<T> push<T extends Object>([Object args]) {
    return ScreenRouter.key.currentState
        .pushNamed<T>(this.toString(), arguments: args);
  }

  Future<T> pushReplacementNamed<T extends Object, TO extends Object>({
    TO result,
    Object arguments,
  }) {
    return ScreenRouter.key.currentState.pushReplacementNamed<T, TO>(
        this.toString(),
        arguments: arguments,
        result: result);
  }

  Future<T> popAndPushNamed<T extends Object, TO extends Object>({
    TO result,
    Object arguments,
  }) {
    return ScreenRouter.key.currentState.popAndPushNamed<T, TO>(this.toString(),
        arguments: arguments, result: result);
  }

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
    RoutePredicate predicate, [
    Object arguments,
  ]) {
    return ScreenRouter.key.currentState.pushNamedAndRemoveUntil<T>(
        this.toString(), predicate,
        arguments: arguments);
  }

  Future<T> pushAndRemoveAll<T extends Object>([
    Object arguments,
  ]) {
    return ScreenRouter.key.currentState.pushNamedAndRemoveUntil<T>(
        this.toString(), (r) => false,
        arguments: arguments);
  }

  Future showAsBottomSheet(BuildContext context,
      {bool isScrollControlled = true, bool isDismissible = true}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      builder: (ctx) {
        return ScreenRouter.routes[this.toString()](context);
      },
    );
  }

  Future showAsDialog(BuildContext context,
      {bool isScrollControlled = true, bool isDismissible = true}) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(child: ScreenRouter.routes[this.toString()](context));
      },
    );
  }
}
