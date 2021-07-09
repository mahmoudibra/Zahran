import 'dart:async';

import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/source/local/shared_prefrence/local_data_manager.impl.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/presentation/localization/locale_builder.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'data/repo/user.repo.dart';
import 'domain/models/localization.domain.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase app, This method should be called before any usage of FlutterFire plugins
  await FCMConfig.instance.init();
// initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(LocalizedNameAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TargetAdapter());
  Hive.registerAdapter(LoginModelAdapter());
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded(() {
    runApp(ZahranApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class ZahranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
        init: AuthViewModel(LocalDataManagerImpl()),
        builder: (_) {
          return LocaleBuilder(
            builder: (Locale locale) {
              return MaterialApp(
                themeMode: ThemeMode.light,
                onGenerateTitle: (context) => TR.of(context).appName,
                localizationsDelegates: [
                  ...TR.localizationsDelegates,
                  SimpleLocalizations.delegate,
                  ReusableLocalizations.delegate
                ],
                supportedLocales: TR.supportedLocales,
                locale: locale,
                routes: ScreenRouter.routes,
                navigatorKey: ScreenRouter.key,
                theme: ThemeGenerator.generate(),
              );
            },
          );
        });
  }
}
