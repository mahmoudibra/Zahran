import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'tr_ar.dart';
import 'tr_en.dart';

/// Callers can lookup localized strings with an instance of TR returned
/// by `TR.of(context)`.
///
/// Applications need to include `TR.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'localization/tr.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TR.localizationsDelegates,
///   supportedLocales: TR.supportedLocales,
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
/// be consistent with the languages listed in the TR.supportedLocales
/// property.
abstract class TR {
  TR(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TR of(BuildContext context) {
    return Localizations.of<TR>(context, TR)!;
  }

  static const LocalizationsDelegate<TR> delegate = _TRDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Zahran'**
  String get appName;

  /// No description provided for @visit_details_status_running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get visit_details_status_running;

  /// No description provided for @visit_details_status_new.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get visit_details_status_new;

  /// No description provided for @visit_details_status_pending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get visit_details_status_pending;

  /// No description provided for @visit_details_status_completed.
  ///
  /// In en, this message translates to:
  /// **'complete'**
  String get visit_details_status_completed;

  /// No description provided for @visit_details_status_incomplete.
  ///
  /// In en, this message translates to:
  /// **'incomplete'**
  String get visit_details_status_incomplete;

  /// No description provided for @visit_status_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get visit_status_in_progress;

  /// No description provided for @ticket_severity_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get ticket_severity_high;

  /// No description provided for @ticket_severity_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get ticket_severity_low;

  /// No description provided for @ticket_severity_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get ticket_severity_medium;

  /// No description provided for @we_are_sorry.
  ///
  /// In en, this message translates to:
  /// **'We Are Sorry'**
  String get we_are_sorry;

  /// No description provided for @generic_error_message.
  ///
  /// In en, this message translates to:
  /// **'The App is running into a problem please try again after a few minutes'**
  String get generic_error_message;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @internet_connection_error_title.
  ///
  /// In en, this message translates to:
  /// **'Issue while connecting to internet'**
  String get internet_connection_error_title;

  /// No description provided for @internet_connection_error_msg.
  ///
  /// In en, this message translates to:
  /// **'Issue while connecting to internet'**
  String get internet_connection_error_msg;

  /// No description provided for @internet_connection_error_try_again_button.
  ///
  /// In en, this message translates to:
  /// **'Try again after connecting to your internet'**
  String get internet_connection_error_try_again_button;

  /// No description provided for @capture_image.
  ///
  /// In en, this message translates to:
  /// **'Take a Picture'**
  String get capture_image;

  /// No description provided for @choose_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose From Gallery'**
  String get choose_from_gallery;

  /// No description provided for @choose_media.
  ///
  /// In en, this message translates to:
  /// **'Choose Media'**
  String get choose_media;

  /// No description provided for @choose_media_description.
  ///
  /// In en, this message translates to:
  /// **'Choose Your prefered Media'**
  String get choose_media_description;

  /// No description provided for @record_video.
  ///
  /// In en, this message translates to:
  /// **'Record Video'**
  String get record_video;

  /// No description provided for @choose_video_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose Video From Gallery'**
  String get choose_video_from_gallery;

  /// No description provided for @permission_access_microphone_title.
  ///
  /// In en, this message translates to:
  /// **'Microphone Access'**
  String get permission_access_microphone_title;

  /// No description provided for @permission_access_microphone_message.
  ///
  /// In en, this message translates to:
  /// **'We need to access your microphone to be able to record voice notes!'**
  String get permission_access_microphone_message;

  /// No description provided for @permission_access_location_title.
  ///
  /// In en, this message translates to:
  /// **'Location Access'**
  String get permission_access_location_title;

  /// No description provided for @permission_access_location_message.
  ///
  /// In en, this message translates to:
  /// **'We need to access your location to detect your zone!'**
  String get permission_access_location_message;

  /// No description provided for @permission_access_camera_title.
  ///
  /// In en, this message translates to:
  /// **'Camera Access'**
  String get permission_access_camera_title;

  /// No description provided for @permission_access_camera_message.
  ///
  /// In en, this message translates to:
  /// **'We need to access your camera to be able to take photos!'**
  String get permission_access_camera_message;

  /// No description provided for @permission_access_video_camera_message.
  ///
  /// In en, this message translates to:
  /// **'We need to access your camera to be able to take video!'**
  String get permission_access_video_camera_message;

  /// No description provided for @permission_access_gallery_title.
  ///
  /// In en, this message translates to:
  /// **'Gallery Access'**
  String get permission_access_gallery_title;

  /// No description provided for @permission_access_gallery_message.
  ///
  /// In en, this message translates to:
  /// **'We need to access your gallery to be able to pick photos!'**
  String get permission_access_gallery_message;

  /// No description provided for @permission_access_video_gallery_message.
  ///
  /// In en, this message translates to:
  /// **'We need to access your gallery to be able to pick video!'**
  String get permission_access_video_gallery_message;

  /// No description provided for @permission_access_change_settings_button.
  ///
  /// In en, this message translates to:
  /// **'Change Settings'**
  String get permission_access_change_settings_button;

  /// No description provided for @permission_access_dismiss_button.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get permission_access_dismiss_button;

  /// No description provided for @generic_pop_up_dismiss_button.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get generic_pop_up_dismiss_button;

  /// No description provided for @error_dialog_header.
  ///
  /// In en, this message translates to:
  /// **'Your operation failed'**
  String get error_dialog_header;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'dismiss'**
  String get dismiss;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Lets Get Started'**
  String get login_title;

  /// No description provided for @login_sub_title.
  ///
  /// In en, this message translates to:
  /// **'Login to start eliminate your tasks.'**
  String get login_sub_title;

  /// No description provided for @sab_number.
  ///
  /// In en, this message translates to:
  /// **'Sab-Number'**
  String get sab_number;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @inavlid_sab.
  ///
  /// In en, this message translates to:
  /// **'Sab-number should consist of 6 to 8 numbers'**
  String get inavlid_sab;

  /// No description provided for @inavlid_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 numbers'**
  String get inavlid_password;

  /// No description provided for @visits.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get visits;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {user}'**
  String welcome(Object user);

  /// No description provided for @lets_get_to_work.
  ///
  /// In en, this message translates to:
  /// **'Let’s get to work ✍️'**
  String get lets_get_to_work;

  /// No description provided for @upcoming_visits.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Visits'**
  String get upcoming_visits;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @incomplete.
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get incomplete;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;
}

class _TRDelegate extends LocalizationsDelegate<TR> {
  const _TRDelegate();

  @override
  Future<TR> load(Locale locale) {
    return SynchronousFuture<TR>(_lookupTR(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TRDelegate old) => false;
}

TR _lookupTR(Locale locale) {
// Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return TRAr();
    case 'en':
      return TREn();
  }

  throw FlutterError(
      'TR.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
