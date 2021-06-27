import 'package:flutter/widgets.dart';

class Routes {
  static const LOGIN_ROUTER = "LOGIN_ROUTER";
  static const LOCATION_SEARCH_ROUTER = "LOCATION_SEARCH_ROUTER";
  static const DETECT_ZONE_ROUTER = "DETECT_ZONE_ROUTER";
  static const MAIN_SCREEN_ROUTER = "MAIN_SCREEN_ROUTER";
  static const COUNTRY_CODE_ROUTER = "COUNTRY_CODE_ROUTER";
  static const VERIFICATION_CODE_SCREEN_ROUTER = "VERIFICATION_CODE_SCREEN_ROUTER";
  static const VENDOR_INFO_ROUTER = "VENDOR_INFO_ROUTER";
  static const MY_ACCOUNT_SCREEN_ROUTER = "MY_ACCOUNT_SCREEN_ROUTER";
  static const DETAILED_SCREEN_ROUTER = "DETAILED_SCREEN_ROUTER";
  static const PLACEHOLDER_SCREEN = "PLACEHOLDER_SCREEN";
  static const FAVORITES_ROUTER = "FAVORITES_ROUTER";
  static const VENDOR_PROFILE_ROUTER = "VENDOR_PROFILE_ROUTER";
  static const ABOUT_ROUTER = "ABOUT_ROUTER";
  static const PRIVACY_POLICY_ROUTER = "PRIVACY_POLICY_ROUTER";
  static const TERMS_AND_CONDITIONS_ROUTER = "TERMS_AND_CONDITIONS_ROUTER";
  static const APP_REVIEW_ROUTER = "APP_REVIEW_ROUTER";
  static const ITEM_DETAILS_ROUTER = "ITEM_DETAILS_ROUTER";
  static const USER_PROFILE_ROUTER = "USER_PROFILE_ROUTER";
  static const SPLASH_ROUTER = "SPLASH_ROUTER";
  static const SERVICE_CATALOG_ROUTER = "SERVICE_CATALOG_ROUTER";
  static const SEARCH_PAGE_ROUTER = "SEARCH_PAGE_ROUTER";
  static const SEARCH_BRANCH_ITEMS = "SEARCH_BRANCH_ITEMS";
  static const ADDRESS_FORM_ROUTER = "ADDRESS_FORM_ROUTER";
  static const CART_PAGE_ROUTER = "CART_PAGE_ROUTER";
  static const SAVED_ADDRESSES_ROUTER = "SAVED_ADDRESSES_ROUTER";
  static const CHECKOUT_PAGE_ROUTER = "CHECKOUT_PAGE_ROUTER";
  static const ORDER_DETAILS_ROUTER = "ORDER_DETAILS_ROUTER";
  static const TEST_DRIVER_ROUTER = "TEST_DRIVER_ROUTER";
  static const ERRANDS_MAIN_PAGE_ROUTER = "ERRANDS_MAIN_PAGE_ROUTER";
  static const ORDER_TRACKING_ROUTER = "ORDER_TRACKING_ROUTER";
  static const C2C_CHECKOUT_ROUTER = "C2C_CHECKOUT_ROUTER";
  static const PHOTO_VIEWER = "PHOTO_VIEWER";
  static const FORCE_UPDATE_ROUTER = "FORCE_UPDATE_ROUTER";
  static const PROMO_CODES_ROUTER = "PROMO_CODES_ROUTER";
  static const PROMO_CODE_VENDOR_ROUTER = "PROMO_CODE_VENDOR_ROUTER";
  static const REFERRAL_ROUTER = "REFERRAL_ROUTER";
  static const ERRANDS_PICKUP_POINT_DETAILS = "ERRANDS_PICKUP_POINT_DETAILS";
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
