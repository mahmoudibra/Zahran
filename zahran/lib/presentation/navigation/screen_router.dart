import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/home_screen/home_screen.dart';
import 'package:zahran/presentation/business/login_screen/login_screen.dart';
import 'package:zahran/presentation/business/more/branch/branch_list_screen.dart';
import 'package:zahran/presentation/business/more/brands/brand_list_screen.dart';
import 'package:zahran/presentation/business/more/change_password/change_password_screen.dart';
import 'package:zahran/presentation/business/more/profile/profile_screen.dart';
import 'package:zahran/presentation/business/more/promotions/details/promotion_details_screen.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_list_screen.dart';
import 'package:zahran/presentation/business/more/setting/seeting_screen.dart';
import 'package:zahran/presentation/business/splash/splash_screen.dart';
import 'package:zahran/presentation/business/visits/details/visit_details.dart';

part 'screen_extensions.dart';

enum ScreenNames {
  LOGIN,
  LOGIN_SHEET,
  SPLASH,
  HOME,
  VISIT_DETAILS,
  USER_PROFILE,
  CHANGE_PASSWORD,
  SETTING,
  PROMOTION_LIST,
  PROMOTION_DETAILS,
  BRANCH_LIST,
  BRANDS_LIST,
}

class ScreenRouter {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  //! Routes
  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => SplashScreen(),
        "${ScreenNames.SPLASH}": (_) => SplashScreen(),
        "${ScreenNames.LOGIN}": (_) => LoginScreen(),
        "${ScreenNames.LOGIN_SHEET}": (_) => LoginSheet(),
        "${ScreenNames.HOME}": (_) => HomeScreen(),
        "${ScreenNames.USER_PROFILE}": (_) => UserProfileScreen(),
        "${ScreenNames.CHANGE_PASSWORD}": (_) => ChangePasswordScreen(),
        "${ScreenNames.VISIT_DETAILS}": (_) => VisitDetails(),
        "${ScreenNames.SETTING}": (_) => SettingScreen(),
        "${ScreenNames.PROMOTION_LIST}": (_) => PromotionListScreen(),
        "${ScreenNames.PROMOTION_DETAILS}": (_) => PromotionDetailsScreen(promotionId: 5),
        "${ScreenNames.BRANCH_LIST}": (_) => BranchesListScreen(),
        "${ScreenNames.BRANDS_LIST}": (_) => BrandsListScreen(),
      };

  static void pop<T extends Object>([T? result]) {
    return key.currentState!.pop(result);
  }
}
