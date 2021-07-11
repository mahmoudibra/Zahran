import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/home_screen/home_screen.dart';
import 'package:zahran/presentation/business/login_screen/login_screen.dart';
import 'package:zahran/presentation/business/more/change_password/change_password_screen.dart';
import 'package:zahran/presentation/business/more/profile/profile_screen.dart';
import 'package:zahran/presentation/business/more/setting/seeting_screen.dart';
import 'package:zahran/presentation/business/splash/splash_screen.dart';
import 'package:zahran/presentation/business/visits/details/visit_details.dart';

part 'screen_extensions.dart';

enum ScreenNames { LOGIN, LOGIN_SHEET, SPLASH, HOME, VISIT_DETAILS, USER_PROFILE, CHANGE_PASSWORD, SETTING }

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
      };

  static void pop<T extends Object>([T? result]) {
    return key.currentState!.pop(result);
  }
}
