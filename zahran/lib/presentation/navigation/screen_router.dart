import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/home_screen/home_screen.dart';
import 'package:zahran/presentation/business/login_screen/login_screen.dart';
import 'package:zahran/presentation/business/more/change_password/change_password_screen.dart';
import 'package:zahran/presentation/business/more/profile/profile_screen.dart';
import 'package:zahran/presentation/business/splash/splash_screen.dart';
import 'package:zahran/presentation/business/visits/details/visit_details.dart';

part 'screen_extensions.dart';

enum ScreenNames { login, login_sheet, splash, home, visit_details, userProfile, changePassword }

class ScreenRouter {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  //! Routes
  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => SplashScreen(),
        "${ScreenNames.splash}": (_) => SplashScreen(),
        "${ScreenNames.login}": (_) => LoginScreen(),
        "${ScreenNames.login_sheet}": (_) => LoginSheet(),
        "${ScreenNames.home}": (_) => HomeScreen(),
        "${ScreenNames.userProfile}": (_) => UserProfileScreen(),
        "${ScreenNames.changePassword}": (_) => ChangePasswordScreen(),
        "${ScreenNames.visit_details}": (_) => VisitDetails(),
      };

  static void pop<T extends Object>([T? result]) {
    return key.currentState!.pop(result);
  }
}
