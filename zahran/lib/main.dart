import 'dart:async';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/localization/locale_builder.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'domain/models/models.dart';
import 'presentation/commom/app_loader.dart';
import 'r.dart';
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
  Hive.registerAdapter(ReportItemAdapter());
  Hive.registerAdapter(ReportModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());
  Hive.registerAdapter(ReportTypesAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(MediaUploadAdapter());
  Hive.registerAdapter(ProblemDetailsModelAdapter());
  Hive.registerAdapter(SeverityAdapter());
  // if (kDebugMode) {
  //   // Force disable Crashlytics collection while doing every day development.
  //   // Temporarily toggle this to true if you want to test crash reporting in your app.
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // }
  // // Pass all uncaught errors to Crashlytics.

  //
  // runZonedGuarded(() {
  //
  // }, FirebaseCrashlytics.instance.recordError);

  runApp(ZahranApp());
}

class ZahranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShapedRemoteImageConfig(
      errorPlaceholder: (_, __, ___) =>
          Image.asset(R.assetsImagesTestBackground, fit: BoxFit.cover),
      loadingPlaceholder: (_, __, ___) {
        return Container(
          color: Theme.of(_).canvasColor,
          child: Center(
            child: Container(child: AppLoader()),
          ),
        );
      },
      child: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (_) {
            return LocaleBuilder(
              builder: (Locale locale) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: ThemeMode.light,
                  onGenerateTitle: (context) => TR.of(context).appName,
                  localizationsDelegates: [
                    ...TR.localizationsDelegates,
                    SimpleLocalizations.delegate,
                    ReusableLocalizations.delegate
                  ],
                  supportedLocales: TR.supportedLocales,
                  // locale: locale,
                  locale: Locale('en'),
                  routes: ScreenRouter.routes,
                  navigatorKey: ScreenRouter.key,
                  theme: ThemeGenerator.generate(),
                  navigatorObservers: [context.snackBarObserver],
                );
              },
            );
          }),
    );
  }
}
