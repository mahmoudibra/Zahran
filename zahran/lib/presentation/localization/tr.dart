// ignore_for_file: non_constant_identifier_names

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
  /// **'Groupe SEB'**
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
  /// **'Choose Your preferred Media'**
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

  /// No description provided for @invalid_sab.
  ///
  /// In en, this message translates to:
  /// **'Sab-number should consist of 3 to 7 numbers'**
  String get invalid_sab;

  /// No description provided for @invalid_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 numbers'**
  String get invalid_password;

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

  /// No description provided for @tasksLabel.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{} =1{Task} =2{Tasks}  few{Tasks} other{Tasks}'**
  String tasksLabel(int count);

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

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @get_directions.
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get get_directions;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get see_all;

  /// No description provided for @task_count.
  ///
  /// In en, this message translates to:
  /// **'Tasks ({count})'**
  String task_count(Object count);

  /// No description provided for @check_in.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get check_in;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get promotion;

  /// No description provided for @invalid_user_name.
  ///
  /// In en, this message translates to:
  /// **'Username should not be empty'**
  String get invalid_user_name;

  /// No description provided for @invalid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number length should be 11 digit'**
  String get invalid_phone_number;

  /// No description provided for @change_image.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get change_image;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// No description provided for @personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personal_info;

  /// No description provided for @un_expected_error.
  ///
  /// In en, this message translates to:
  /// **'unexpected error please try again later.'**
  String get un_expected_error;

  /// No description provided for @user_profile_updated.
  ///
  /// In en, this message translates to:
  /// **'User profile data updates successfully.'**
  String get user_profile_updated;

  /// No description provided for @old_password.
  ///
  /// In en, this message translates to:
  /// **'Old password'**
  String get old_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirm_new_password;

  /// No description provided for @invalid_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'new password & confirm password are not matched'**
  String get invalid_confirm_password;

  /// No description provided for @user_password_changed_successfully.
  ///
  /// In en, this message translates to:
  /// **'User Password changed successfully'**
  String get user_password_changed_successfully;

  /// No description provided for @user_setting_updated.
  ///
  /// In en, this message translates to:
  /// **'User setting updated'**
  String get user_setting_updated;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @allow_notifications.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications'**
  String get allow_notifications;

  /// No description provided for @allow_notifications_description.
  ///
  /// In en, this message translates to:
  /// **'Get notified when you get a new inbox \naction item.'**
  String get allow_notifications_description;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'english'**
  String get english;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'{distnace} KM'**
  String distance(Object distnace);

  /// No description provided for @distance_away.
  ///
  /// In en, this message translates to:
  /// **'{distnace}KM away'**
  String distance_away(Object distnace);

  /// No description provided for @total_sell_out.
  ///
  /// In en, this message translates to:
  /// **'Total Sell-out'**
  String get total_sell_out;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @last_visit.
  ///
  /// In en, this message translates to:
  /// **'Last visit'**
  String get last_visit;

  /// No description provided for @promotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get promotions;

  /// No description provided for @branches.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get branches;

  /// No description provided for @brands_products.
  ///
  /// In en, this message translates to:
  /// **'Brands / Products'**
  String get brands_products;

  /// No description provided for @sallary_slip.
  ///
  /// In en, this message translates to:
  /// **'Sallary Slip'**
  String get sallary_slip;

  /// No description provided for @shared_documents.
  ///
  /// In en, this message translates to:
  /// **'Shared documents'**
  String get shared_documents;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @start_date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get start_date;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get end_date;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @display_type.
  ///
  /// In en, this message translates to:
  /// **'Display Type'**
  String get display_type;

  /// No description provided for @chain.
  ///
  /// In en, this message translates to:
  /// **'chain'**
  String get chain;

  /// No description provided for @brands_list_num.
  ///
  /// In en, this message translates to:
  /// **'Brands List (brandNumber)'**
  String brands_list_num(Object brandNumber);

  /// No description provided for @sub_brands_list.
  ///
  /// In en, this message translates to:
  /// **'SubBrands List (subBrandNumber)'**
  String sub_brands_list(Object subBrandNumber);

  /// No description provided for @problem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get problem;

  /// No description provided for @competition.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get competition;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @sub_brand.
  ///
  /// In en, this message translates to:
  /// **'Sub brand'**
  String get sub_brand;

  /// No description provided for @campaign_details.
  ///
  /// In en, this message translates to:
  /// **'Campaign Details'**
  String get campaign_details;

  /// No description provided for @promotion_details.
  ///
  /// In en, this message translates to:
  /// **'Promotion Details'**
  String get promotion_details;

  /// No description provided for @get_direction.
  ///
  /// In en, this message translates to:
  /// **'Get Direction'**
  String get get_direction;

  /// No description provided for @brand_product.
  ///
  /// In en, this message translates to:
  /// **'Brands / Products'**
  String get brand_product;

  /// No description provided for @user_id.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String user_id(Object id);

  /// No description provided for @search_month.
  ///
  /// In en, this message translates to:
  /// **'Search for month'**
  String get search_month;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @payment_type.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get payment_type;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @desiccation.
  ///
  /// In en, this message translates to:
  /// **'Desiccation'**
  String get desiccation;

  /// No description provided for @net_salary.
  ///
  /// In en, this message translates to:
  /// **'Net Salary'**
  String get net_salary;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @check_out.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get check_out;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @check_in_list.
  ///
  /// In en, this message translates to:
  /// **'Check-In'**
  String get check_in_list;

  /// No description provided for @check_in_search.
  ///
  /// In en, this message translates to:
  /// **'Search for city, chain and branch 🔎'**
  String get check_in_search;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @message_details.
  ///
  /// In en, this message translates to:
  /// **'Message Details'**
  String get message_details;

  /// No description provided for @can_not_open_file.
  ///
  /// In en, this message translates to:
  /// **'Sorry! We can\'t find any app that can open this file'**
  String get can_not_open_file;

  /// No description provided for @are_you_sure_logout.
  ///
  /// In en, this message translates to:
  /// **'are you sure you want to logout'**
  String get are_you_sure_logout;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @image_preview.
  ///
  /// In en, this message translates to:
  /// **'Image Preview'**
  String get image_preview;

  /// No description provided for @video_preview.
  ///
  /// In en, this message translates to:
  /// **'Video Preview'**
  String get video_preview;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @task_details.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get task_details;

  /// No description provided for @task_description.
  ///
  /// In en, this message translates to:
  /// **'Task Description'**
  String get task_description;

  /// No description provided for @action_to_be_done.
  ///
  /// In en, this message translates to:
  /// **'Action to be done'**
  String get action_to_be_done;

  /// No description provided for @brands_num.
  ///
  /// In en, this message translates to:
  /// **'Brands ({count})'**
  String brands_num(Object count);

  /// No description provided for @complete_task.
  ///
  /// In en, this message translates to:
  /// **'Complete Task'**
  String get complete_task;

  /// No description provided for @task_completed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Task ({task_name}) completed successfully'**
  String task_completed_successfully(Object task_name);

  /// No description provided for @mandatory.
  ///
  /// In en, this message translates to:
  /// **'Mandatory'**
  String get mandatory;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions ({mandatory_or_optional})'**
  String questions(Object mandatory_or_optional);

  /// No description provided for @take_picture.
  ///
  /// In en, this message translates to:
  /// **'Take picture'**
  String get take_picture;

  /// No description provided for @task_question.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get task_question;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get select_date;

  /// No description provided for @question_answer.
  ///
  /// In en, this message translates to:
  /// **'Question Answer...'**
  String get question_answer;

  /// No description provided for @answer_all_mandatory_question_first.
  ///
  /// In en, this message translates to:
  /// **'Answer all mandatory questions first please.'**
  String get answer_all_mandatory_question_first;

  /// No description provided for @complete_all_your_tasks_please_first.
  ///
  /// In en, this message translates to:
  /// **'Complete all your tasks first Please .'**
  String get complete_all_your_tasks_please_first;

  /// No description provided for @you_must_take_image.
  ///
  /// In en, this message translates to:
  /// **'You must take a photo of the branch to be able to complete this process'**
  String get you_must_take_image;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @competition_sell_out.
  ///
  /// In en, this message translates to:
  /// **'Competition sell-out'**
  String get competition_sell_out;

  /// No description provided for @competition_stock_count.
  ///
  /// In en, this message translates to:
  /// **'Competition stock-count'**
  String get competition_stock_count;

  /// No description provided for @sell_out.
  ///
  /// In en, this message translates to:
  /// **'Sell Out'**
  String get sell_out;

  /// No description provided for @stock_count.
  ///
  /// In en, this message translates to:
  /// **'Stock Count'**
  String get stock_count;

  /// No description provided for @return_report.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get return_report;

  /// No description provided for @supply.
  ///
  /// In en, this message translates to:
  /// **'Supply Order'**
  String get supply;

  /// No description provided for @select_report_option.
  ///
  /// In en, this message translates to:
  /// **'Select report option'**
  String get select_report_option;

  /// No description provided for @comment_report.
  ///
  /// In en, this message translates to:
  /// **'Comment report'**
  String get comment_report;

  /// No description provided for @enter_decription_here.
  ///
  /// In en, this message translates to:
  /// **'Enter decription here'**
  String get enter_decription_here;

  /// No description provided for @add_product.
  ///
  /// In en, this message translates to:
  /// **'ADD PRODUCT'**
  String get add_product;

  /// No description provided for @search_brand.
  ///
  /// In en, this message translates to:
  /// **'Search for Brands / Products'**
  String get search_brand;

  /// No description provided for @add_product_hint.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get add_product_hint;

  /// No description provided for @add_product_hint_2.
  ///
  /// In en, this message translates to:
  /// **'To complete report add the products'**
  String get add_product_hint_2;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @product_already_added.
  ///
  /// In en, this message translates to:
  /// **'Product already added'**
  String get product_already_added;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @competition_name.
  ///
  /// In en, this message translates to:
  /// **'Competition name'**
  String get competition_name;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @problem_title.
  ///
  /// In en, this message translates to:
  /// **'Problem title'**
  String get problem_title;

  /// No description provided for @problem_type.
  ///
  /// In en, this message translates to:
  /// **'Problem type'**
  String get problem_type;

  /// No description provided for @enter_problem_title.
  ///
  /// In en, this message translates to:
  /// **'Enter problem title'**
  String get enter_problem_title;

  /// No description provided for @enter_problem_type.
  ///
  /// In en, this message translates to:
  /// **'Enter Problem type'**
  String get enter_problem_type;

  /// No description provided for @severity.
  ///
  /// In en, this message translates to:
  /// **'Severity Level'**
  String get severity;

  /// No description provided for @sell_out_report.
  ///
  /// In en, this message translates to:
  /// **'Sell out report'**
  String get sell_out_report;

  /// No description provided for @stock_count_report.
  ///
  /// In en, this message translates to:
  /// **'Stock count report'**
  String get stock_count_report;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @quantity_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter quantity here'**
  String get quantity_hint;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'price'**
  String get price;

  /// No description provided for @price_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter price here'**
  String get price_hint;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @invalid_quantity.
  ///
  /// In en, this message translates to:
  /// **'Invalid quantity'**
  String get invalid_quantity;

  /// No description provided for @invalid_price.
  ///
  /// In en, this message translates to:
  /// **'Invalid price'**
  String get invalid_price;

  /// No description provided for @return_report_title.
  ///
  /// In en, this message translates to:
  /// **'Return report'**
  String get return_report_title;

  /// No description provided for @return_reason.
  ///
  /// In en, this message translates to:
  /// **'Reason of return'**
  String get return_reason;

  /// No description provided for @return_reason_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter reason here'**
  String get return_reason_hint;

  /// No description provided for @sendReportPopUpContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to send the report now, you won\'t be able to send the report again until tomorrow'**
  String get sendReportPopUpContent;

  /// No description provided for @take_picture_or_video.
  ///
  /// In en, this message translates to:
  /// **'Pick Media'**
  String get take_picture_or_video;

  /// No description provided for @voice_note_dismiss_button.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get voice_note_dismiss_button;

  /// No description provided for @voice_note_status_stopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped recording'**
  String get voice_note_status_stopped;

  /// No description provided for @voice_note_status_playing.
  ///
  /// In en, this message translates to:
  /// **'Playing voice note...'**
  String get voice_note_status_playing;

  /// No description provided for @voice_note_status_played.
  ///
  /// In en, this message translates to:
  /// **'Playback completed'**
  String get voice_note_status_played;

  /// No description provided for @voice_note_status_resolving.
  ///
  /// In en, this message translates to:
  /// **'Resolving microphone permission'**
  String get voice_note_status_resolving;

  /// No description provided for @voice_note_accept_button.
  ///
  /// In en, this message translates to:
  /// **'Accept Voice Note'**
  String get voice_note_accept_button;

  /// No description provided for @voice_note_status_recording.
  ///
  /// In en, this message translates to:
  /// **'Recording voice note...'**
  String get voice_note_status_recording;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @this_weak.
  ///
  /// In en, this message translates to:
  /// **'This weak'**
  String get this_weak;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'instructions'**
  String get instructions;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get title;

  /// No description provided for @tickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get tickets;

  /// No description provided for @tickets_count.
  ///
  /// In en, this message translates to:
  /// **'Tickets ({count})'**
  String tickets_count(Object count);

  /// No description provided for @resolve.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get resolve;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;
}

class _TRDelegate extends LocalizationsDelegate<TR> {
  const _TRDelegate();

  @override
  Future<TR> load(Locale locale) {
    return SynchronousFuture<TR>(lookupTR(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TRDelegate old) => false;
}

TR lookupTR(Locale locale) {
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
