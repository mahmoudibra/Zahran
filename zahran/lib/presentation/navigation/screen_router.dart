import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/home_screen/home_screen.dart';
import 'package:zahran/presentation/business/login_screen/login_screen.dart';
import 'package:zahran/presentation/business/splash/splash_screen.dart';

part 'screen_extensions.dart';

enum ScreenNames {
  login,
  splash,
  home,
}

class ScreenRouter {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  //! Routes
  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => SplashScreen(),
        "${ScreenNames.splash}": (_) => SplashScreen(),
        "${ScreenNames.login}": (_) => LoginScreen(),
        "${ScreenNames.home}": (_) => HomeScreen(),
      };

  static void pop<T extends Object>([T? result]) {
    return key.currentState!.pop(result);
  }
}
