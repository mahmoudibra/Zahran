import 'package:intl/intl.dart' as intl;
import 'tr.dart';

/// The translations for English (`en`).
class TREn extends TR {
  TREn([String locale = 'en']) : super(locale);

  @override
  String get tryAgain => 'Try Again';

  @override
  String get appName => 'Groupe SEB';

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
  String get choose_media_description => 'Choose Your preferred Media';

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
  String get invalid_sab => 'Sab-number should consist of 3 to 7 numbers';

  @override
  String get invalid_password => 'Password must be at least 6 numbers';

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
  String tasksLabel(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: 'Task',
      two: 'Tasks',
      few: 'Tasks',
      other: 'Tasks',
    );
  }

  @override
  String get running => 'Running';

  @override
  String get incomplete => 'Incomplete';

  @override
  String get completed => 'Completed';

  @override
  String get back => 'Back';

  @override
  String get get_directions => 'Get directions';

  @override
  String get see_all => 'See all';

  @override
  String task_count(Object count) {
    return 'Tasks ($count)';
  }

  @override
  String get check_in => 'Check-in';

  @override
  String get report => 'Report';

  @override
  String get promotion => 'Promotion';

  @override
  String get invalid_user_name => 'Username should not be empty';

  @override
  String get invalid_phone_number => 'Phone number length should be 11 digit';

  @override
  String get change_image => 'Change Image';

  @override
  String get username => 'Username';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get change_password => 'Change password';

  @override
  String get personal_info => 'Personal Info';

  @override
  String get un_expected_error => 'unexpected error please try again later.';

  @override
  String get user_profile_updated => 'User profile data updates successfully.';

  @override
  String get old_password => 'Old password';

  @override
  String get new_password => 'New password';

  @override
  String get confirm_new_password => 'Confirm new password';

  @override
  String get invalid_confirm_password =>
      'new password & confirm password are not matched';

  @override
  String get user_password_changed_successfully =>
      'User Password changed successfully';

  @override
  String get user_setting_updated => 'User setting updated';

  @override
  String get setting => 'Setting';

  @override
  String get language => 'Language';

  @override
  String get allow_notifications => 'Allow Notifications';

  @override
  String get allow_notifications_description =>
      'Get notified when you get a new inbox \naction item.';

  @override
  String get arabic => 'arabic';

  @override
  String get english => 'english';

  @override
  String distance(Object distnace) {
    return '$distnace KM';
  }

  @override
  String distance_away(Object distnace) {
    return '${distnace}KM away';
  }

  @override
  String get total_sell_out => 'Total Sell-out';

  @override
  String get target => 'Target';

  @override
  String get last_visit => 'Last visit';

  @override
  String get promotions => 'Promotions';

  @override
  String get branches => 'Branches';

  @override
  String get brands_products => 'Brands / Products';

  @override
  String get sallary_slip => 'Sallary Slip';

  @override
  String get shared_documents => 'Shared documents';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get start_date => 'Start Date';

  @override
  String get end_date => 'End Date';

  @override
  String get active => 'Active';

  @override
  String get expired => 'Expired';

  @override
  String get all => 'All';

  @override
  String get display_type => 'Display Type';

  @override
  String get chain => 'chain';

  @override
  String brands_list_num(Object brandNumber) {
    return 'Brands List (brandNumber)';
  }

  @override
  String sub_brands_list(Object subBrandNumber) {
    return 'SubBrands List (subBrandNumber)';
  }

  @override
  String get problem => 'Problem';

  @override
  String get competition => 'Competition';

  @override
  String get brand => 'Brand';

  @override
  String get sub_brand => 'Sub brand';

  @override
  String get campaign_details => 'Campaign Details';

  @override
  String get promotion_details => 'Promotion Details';

  @override
  String get get_direction => 'Get Direction';

  @override
  String get brand_product => 'Brands / Products';

  @override
  String user_id(Object id) {
    return 'ID: $id';
  }

  @override
  String get search_month => 'Search for month';

  @override
  String get department => 'Department';

  @override
  String get bank => 'Bank';

  @override
  String get payment_type => 'Payment type';

  @override
  String get total => 'Total';

  @override
  String get desiccation => 'Desiccation';

  @override
  String get net_salary => 'Net Salary';

  @override
  String get earnings => 'Earnings';

  @override
  String get amount => 'Amount';

  @override
  String get rate => 'Rate';

  @override
  String get check_out => 'Check-out';

  @override
  String get documents => 'Documents';

  @override
  String get check_in_list => 'Check-In';

  @override
  String get check_in_search => 'Search for city, chain and branch 🔎';

  @override
  String get notification => 'Notification';

  @override
  String get message_details => 'Message Details';

  @override
  String get can_not_open_file =>
      'Sorry! We can\'t find any app that can open this file';

  @override
  String get are_you_sure_logout => 'are you sure you want to logout';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get image_preview => 'Image Preview';

  @override
  String get video_preview => 'Video Preview';

  @override
  String get reports => 'Reports';

  @override
  String get task_details => 'Task Details';

  @override
  String get task_description => 'Task Description';

  @override
  String get action_to_be_done => 'Action to be done';

  @override
  String brands_num(Object count) {
    return 'Brands ($count)';
  }

  @override
  String get complete_task => 'Complete Task';

  @override
  String task_completed_successfully(Object task_name) {
    return 'Task ($task_name) completed successfully';
  }

  @override
  String get mandatory => 'Mandatory';

  @override
  String get optional => 'Optional';

  @override
  String questions(Object mandatory_or_optional) {
    return 'Questions ($mandatory_or_optional)';
  }

  @override
  String get take_picture => 'Take picture';

  @override
  String get task_question => 'Questions';

  @override
  String get select_date => 'Select Date';

  @override
  String get question_answer => 'Question Answer...';

  @override
  String get answer_all_mandatory_question_first =>
      'Answer all mandatory questions first please.';

  @override
  String get complete_all_your_tasks_please_first =>
      'Complete all your tasks first Please .';

  @override
  String get you_must_take_image =>
      'You must take a photo of the branch to be able to complete this process';

  @override
  String get comment => 'Comment';

  @override
  String get competition_sell_out => 'Competition sell-out';

  @override
  String get competition_stock_count => 'Competition stock-count';

  @override
  String get sell_out => 'Sell Out';

  @override
  String get stock_count => 'Stock Count';

  @override
  String get return_report => 'Return';

  @override
  String get supply => 'Supply Order';

  @override
  String get select_report_option => 'Select report option';

  @override
  String get comment_report => 'Comment report';

  @override
  String get enter_decription_here => 'Enter decription here';

  @override
  String get add_product => 'ADD PRODUCT';

  @override
  String get search_brand => 'Search for Brands / Products';

  @override
  String get add_product_hint => 'Add Product';

  @override
  String get add_product_hint_2 => 'To complete report add the products';

  @override
  String get product => 'Product';

  @override
  String get product_already_added => 'Product already added';

  @override
  String get send => 'Send';

  @override
  String get competition_name => 'Competition name';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get problem_title => 'Problem title';

  @override
  String get problem_type => 'Problem type';

  @override
  String get enter_problem_title => 'Enter problem title';

  @override
  String get enter_problem_type => 'Enter Problem type';

  @override
  String get severity => 'Severity Level';

  @override
  String get sell_out_report => 'Sell out report';

  @override
  String get stock_count_report => 'Stock count report';

  @override
  String get quantity => 'Quantity';

  @override
  String get quantity_hint => 'Enter quantity here';

  @override
  String get price => 'price';

  @override
  String get price_hint => 'Enter price here';

  @override
  String get add => 'Add';

  @override
  String get edit => 'Edit';

  @override
  String get invalid_quantity => 'Invalid quantity';

  @override
  String get invalid_price => 'Invalid price';

  @override
  String get return_report_title => 'Return report';

  @override
  String get return_reason => 'Reason of return';

  @override
  String get return_reason_hint => 'Enter reason here';

  @override
  String get sendReportPopUpContent =>
      'Do you want to send the report now, you won\'t be able to send the report again until tomorrow';

  @override
  String get take_picture_or_video => 'Pick Media';

  @override
  String get voice_note_dismiss_button => 'Dismiss';

  @override
  String get voice_note_status_stopped => 'Stopped recording';

  @override
  String get voice_note_status_playing => 'Playing voice note...';

  @override
  String get voice_note_status_played => 'Playback completed';

  @override
  String get voice_note_status_resolving => 'Resolving microphone permission';

  @override
  String get voice_note_accept_button => 'Accept Voice Note';

  @override
  String get voice_note_status_recording => 'Recording voice note...';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get this_weak => 'This weak';

  @override
  String get instructions => 'instructions';

  @override
  String get title => 'title';

  @override
  String get tickets => 'Tickets';

  @override
  String tickets_count(Object count) {
    return 'Tickets ($count)';
  }

  @override
  String get resolve => 'Resolve';

  @override
  String get other => 'Other';
}
