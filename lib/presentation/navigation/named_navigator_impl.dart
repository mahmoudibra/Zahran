import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';

import 'named-navigator.dart';

class NamedNavigatorImpl implements NamedNavigator {
  static final GlobalKey<NavigatorState> navigatorState = new GlobalKey<NavigatorState>();

  static String _currentRouteName;
  static String _previousRouteName;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    _currentRouteName = settings.name;
    switch (settings.name) {
      // case Routes.LOGIN_ROUTER:
      //   return _fadeInRoute(
      //       page: LoginPage(
      //     settings.arguments,
      //   ));
      // case Routes.FAVORITES_ROUTER:
      //   return MaterialPageRoute(
      //     builder: (_) => FavoritesVendorsItemsPage(),
      //   );
      case Routes.SPLASH_ROUTER:
        return _fadeInRoute(page: Container());
        return MaterialPageRoute(builder: (_) => Container());
    }
  }

  @override
  void pop({dynamic result}) {
    if (navigatorState.currentState.canPop()) navigatorState.currentState.pop(result);
  }

  @override
  Future push(String routeName, {arguments, bool replace = false, bool clean = false, bool replaceIfCurrent = false}) {
    _previousRouteName = _currentRouteName;
    if (clean)
      return navigatorState.currentState.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);

    if (replace || (replaceIfCurrent && _currentRouteName == routeName))
      return navigatorState.currentState.pushReplacementNamed(routeName, arguments: arguments);

    return navigatorState.currentState.pushNamed(routeName, arguments: arguments);
  }

  @override
  bool canPop() {
    return navigatorState.currentState.canPop();
  }

  @override
  Future showBottomSheet({@required BottomSheets bottomSheet, @required bool isDismissible}) {
    Widget bottomSheetWidget = ViewsToolbox.emptyWidget();
    switch (bottomSheet) {
      case BottomSheets.UPDATE_CUSTOMER_DATA_BOTTOM_SHEET:
        // bottomSheetWidget = CustomerDataBottomSheet();
        break;
      case BottomSheets.ADD_REFERRAL_CODE:
      // bottomSheetWidget = ReferralCodeBottomSheet();
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        context: navigatorState.currentContext,
        builder: (context) => bottomSheetWidget,
        isDismissible: isDismissible);
  }

  // Helpers
  static PageRoute _fadeInRoute({Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          Scaffold(backgroundColor: Theme.of(context).backgroundColor, body: page),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void systemPop() {
    SystemNavigator.pop();
  }

  @override
  String get previousRoute => _previousRouteName;

  @override
  void showPopup(
      {@required type,
      Map<String, dynamic> parameters,
      Map<String, Function> actionsCallbacks,
      bool barrierDismissible = true}) {
    Widget _popup;
    switch (type) {
      case PopupsTypes.GENERAL:
        // _popup = GeneralPopup(parameters: parameters, actionsCallbacks: actionsCallbacks);
        break;
      case PopupsTypes.FAILED_TO_ADD_ITEM_POP_UP:
        // _popup = FailedToAddItemPopup(parameters: parameters, actionsCallbacks: actionsCallbacks);
        break;
    }

    if (_popup != null) {
      showDialog(
        context: navigatorState.currentContext,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return _popup;
        },
      );
    }
  }
}
