
import 'dart:async';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'reusable_localizations_ar.dart';
import 'reusable_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ReusableLocalizations returned
/// by `ReusableLocalizations.of(context)`.
///
/// Applications need to include `ReusableLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/reusable_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ReusableLocalizations.localizationsDelegates,
///   supportedLocales: ReusableLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ReusableLocalizations.supportedLocales
/// property.
abstract class ReusableLocalizations {
  ReusableLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String localeName;

  static ReusableLocalizations? of(BuildContext context) {
    return Localizations.of<ReusableLocalizations>(context, ReusableLocalizations);
  }

  static const LocalizationsDelegate<ReusableLocalizations> delegate = _ReusableLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @authorizationMessage.
  ///
  /// In ar, this message translates to:
  /// **'عذرا! ليس لديك الصلاحية لهذا الأمر'**
  String get authorizationMessage;

  /// No description provided for @connectionTimeOutMessage.
  ///
  /// In ar, this message translates to:
  /// **'عذرا! إستغرقت العملية وقت أطول من اللازم'**
  String get connectionTimeOutMessage;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get error;

  /// No description provided for @info.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة'**
  String get info;

  /// No description provided for @loadDone.
  ///
  /// In ar, this message translates to:
  /// **'تم التحميل'**
  String get loadDone;

  /// No description provided for @loadFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل التحميل'**
  String get loadFailed;

  /// No description provided for @loadMore.
  ///
  /// In ar, this message translates to:
  /// **'تحميل المزيد'**
  String get loadMore;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'برجاء الإنتظار ...'**
  String get loading;

  /// No description provided for @lock.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف'**
  String get lock;

  /// No description provided for @noInternetMessage.
  ///
  /// In ar, this message translates to:
  /// **'عذرا! لا يمكن الاتصال بالإنترنت تأكد من جودة الإنترنت لديك'**
  String get noInternetMessage;

  /// No description provided for @noItems.
  ///
  /// In ar, this message translates to:
  /// **'القائمة فارغة'**
  String get noItems;

  /// No description provided for @noMoreItems.
  ///
  /// In ar, this message translates to:
  /// **'إنتهت القائمة'**
  String get noMoreItems;

  /// No description provided for @notFoundMessage.
  ///
  /// In ar, this message translates to:
  /// **'عذرا! الرابط الذي طلبته غير موجود'**
  String get notFoundMessage;

  /// No description provided for @notSuccessResponse.
  ///
  /// In ar, this message translates to:
  /// **'عذرا! فشلت العملية برجاء المحاولة مرة أخري أو الإتصال بالادارة في حال وجود مشكلة'**
  String get notSuccessResponse;

  /// No description provided for @reload.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تحميل'**
  String get reload;

  /// No description provided for @requiredField.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get requiredField;

  /// No description provided for @show.
  ///
  /// In ar, this message translates to:
  /// **'عرض'**
  String get show;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get success;

  /// No description provided for @unlock.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل'**
  String get unlock;

  /// No description provided for @warning.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get warning;
}

class _ReusableLocalizationsDelegate extends LocalizationsDelegate<ReusableLocalizations> {
  const _ReusableLocalizationsDelegate();

  @override
  Future<ReusableLocalizations> load(Locale locale) {
    return SynchronousFuture<ReusableLocalizations>(_lookupReusableLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ReusableLocalizationsDelegate old) => false;
}

ReusableLocalizations _lookupReusableLocalizations(Locale locale) {
  


// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'ar': return ReusableLocalizationsAr();
    case 'en': return ReusableLocalizationsEn();
}


  throw FlutterError(
    'ReusableLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
