import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/presentation/localization/locale_builder.dart';
import 'package:zahran/presentation/navigation/named-navigator.dart';
import 'package:zahran/presentation/navigation/named_navigator_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase app, This method should be called before any usage of FlutterFire plugins
  await Firebase.initializeApp();

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(ZahranApp());
  }, onError: FirebaseCrashlytics.instance.recordError);
}

class ZahranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (Locale locale) {
        return MaterialApp(
          onGenerateTitle: (ctx) => TR.of(context).appName,
          localizationsDelegates: TR.localizationsDelegates,
          supportedLocales: TR.supportedLocales,
          locale: locale,
          initialRoute: Routes.SPLASH_ROUTER,
          onGenerateRoute: NamedNavigatorImpl.onGenerateRoute,
          navigatorKey: NamedNavigatorImpl.navigatorState,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        );
      },
    );
  }
}
