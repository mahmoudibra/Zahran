import 'tr.dart';

/// The translations for English (`en`).
class TREn extends TR {
  TREn([String locale = 'en']) : super(locale);

  @override
  String get tryAgain => 'Try Again';

  @override
  String get appName => 'Zahran';

  @override
  String get visit_details_status_running => 'Running';

  @override
  String get visit_details_status_new => 'New';

  @override
  String get visit_details_status_pending => 'pending';

  @override
  String get visit_details_status_completed => 'complete';

  @override
  String get visit_details_status_incomplete => 'incomplete';

  @override
  String get visit_status_in_progress => 'In progress';

  @override
  String get ticket_severity_high => 'High';

  @override
  String get ticket_severity_low => 'Low';

  @override
  String get ticket_severity_medium => 'Medium';

  @override
  String get we_are_sorry => 'We Are Sorry';

  @override
  String get generic_error_message =>
      'The App is running into a problem please try again after a few minutes';

  @override
  String get try_again => 'Try Again';

  @override
  String get internet_connection_error_title =>
      'Issue while connecting to internet';

  @override
  String get internet_connection_error_msg =>
      'Issue while connecting to internet';

  @override
  String get internet_connection_error_try_again_button =>
      'Try again after connecting to your internet';

  @override
  String get capture_image => 'Take a Picture';

  @override
  String get choose_from_gallery => 'Choose From Gallery';

  @override
  String get choose_media => 'Choose Media';

  @override
  String get choose_media_description => 'Choose Your prefered Media';

  @override
  String get record_video => 'Record Video';

  @override
  String get choose_video_from_gallery => 'Choose Video From Gallery';

  @override
  String get permission_access_microphone_title => 'Microphone Access';

  @override
  String get permission_access_microphone_message =>
      'We need to access your microphone to be able to record voice notes!';

  @override
  String get permission_access_location_title => 'Location Access';

  @override
  String get permission_access_location_message =>
      'We need to access your location to detect your zone!';

  @override
  String get permission_access_camera_title => 'Camera Access';

  @override
  String get permission_access_camera_message =>
      'We need to access your camera to be able to take photos!';

  @override
  String get permission_access_video_camera_message =>
      'We need to access your camera to be able to take video!';

  @override
  String get permission_access_gallery_title => 'Gallery Access';

  @override
  String get permission_access_gallery_message =>
      'We need to access your gallery to be able to pick photos!';

  @override
  String get permission_access_video_gallery_message =>
      'We need to access your gallery to be able to pick video!';

  @override
  String get permission_access_change_settings_button => 'Change Settings';

  @override
  String get permission_access_dismiss_button => 'Dismiss';

  @override
  String get generic_pop_up_dismiss_button => 'Dismiss';

  @override
  String get error_dialog_header => 'Your operation failed';

  @override
  String get dismiss => 'dismiss';

  @override
  String get login_title => 'Lets Get Started';

  @override
  String get login_sub_title => 'Login to start eliminate your tasks.';

  @override
  String get sab_number => 'Sab-Number';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get inavlid_sab => 'Sab-number should consist of 6 to 8 numbers';

  @override
  String get inavlid_password => 'Password must be at least 6 numbers';

  @override
  String get visits => 'Visits';

  @override
  String get profile => 'Profile';

  @override
  String welcome(Object user) {
    return 'Welcome, $user';
  }

  @override
  String get lets_get_to_work => 'Let’s get to work ✍️';

  @override
  String get upcoming_visits => 'Upcoming Visits';

  @override
  String get tasks => 'Tasks';

  @override
  String get running => 'Running';

  @override
  String get incomplete => 'Incomplete';

  @override
  String get completed => 'Completed';
}
