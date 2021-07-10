part of 'screen_router.dart';

extension RouterExtension on ScreenNames {
  Future<T?> push<T extends Object?>([Object? args]) {
    return ScreenRouter.key.currentState!
        .pushNamed<T>(this.toString(), arguments: args);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>({
    TO? result,
    Object? arguments,
  }) {
    return ScreenRouter.key.currentState!.pushReplacementNamed<T, TO>(
        this.toString(),
        arguments: arguments,
        result: result);
  }

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>({
    TO? result,
    Object? arguments,
  }) {
    return ScreenRouter.key.currentState!.popAndPushNamed<T, TO>(
        this.toString(),
        arguments: arguments,
        result: result);
  }

  Future pushNamedAndRemoveUntil(
    RoutePredicate predicate, [
    Object? arguments,
  ]) async {
    await ScreenRouter.key.currentState!.pushNamedAndRemoveUntil(
        this.toString(), predicate,
        arguments: arguments);
  }

  Future pushAndRemoveAll([Object? arguments]) async {
    await ScreenRouter.key.currentState!.pushNamedAndRemoveUntil(
      this.toString(),
      (route) => false,
      arguments: arguments,
    );
  }

  Future showAsBottomSheet(BuildContext context,
      {bool isScrollControlled = true, bool isDismissible = true}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      builder: (ctx) {
        return ScreenRouter.routes[this.toString()]!(context);
      },
    );
  }

  Future showAsDialog(BuildContext context,
      {bool isScrollControlled = true, bool isDismissible = true}) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(child: ScreenRouter.routes[this.toString()]!(context));
      },
    );
  }
}
