import 'package:flutter/widgets.dart';

class Routes {
  static const LOGIN_ROUTER = "LOGIN_ROUTER";
  static const SPLASH_ROUTER = "SPLASH_ROUTER";
}

enum BottomSheets { UPDATE_CUSTOMER_DATA_BOTTOM_SHEET, ADD_REFERRAL_CODE }

enum PopupsTypes {
  GENERAL,
  BRANCH_NOT_AVAILABLE_POP_UP,
  INVALID_PROMO_CODE_POP_UP,
  FAILED_TO_PLACE_ORDER_POP_UP,
  FAILED_TO_ADD_ITEM_POP_UP
}

abstract class NamedNavigator {
  Future push(String routeName,
      {dynamic arguments, bool replace = false, bool clean = false, bool replaceIfCurrent = false});

  void pop({dynamic result});

  bool canPop();

  void systemPop();

  Future showBottomSheet({@required BottomSheets bottomSheet, @required bool isDismissible});

  void showPopup(
      {@required PopupsTypes type,
      Map<String, dynamic> parameters,
      Map<String, Function> actionsCallbacks,
      bool barrierDismissible = true});

  String get previousRoute;
}

class RedirectionRoute {
  final String name;
  final dynamic arguments;

  RedirectionRoute({@required this.name, this.arguments});

  @override
  String toString() {
    return '''RedirectionRoute(name: $name, arguments: $arguments)''';
  }
}
