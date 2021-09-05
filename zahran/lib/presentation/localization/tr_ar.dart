import 'package:intl/intl.dart' as intl;
import 'tr.dart';

/// The translations for Arabic (`ar`).
class TRAr extends TR {
  TRAr([String locale = 'ar']) : super(locale);

  @override
  String get tryAgain => 'حاول مجددا';

  @override
  String get appName => 'زهران';

  @override
  String get visit_details_status_running => 'قيد التشغيل';

  @override
  String get visit_details_status_new => 'جديد';

  @override
  String get visit_details_status_pending => 'قيد الانتظار';

  @override
  String get visit_details_status_completed => 'اكتمال';

  @override
  String get visit_details_status_incomplete => 'غير مكتمل';

  @override
  String get visit_status_in_progress => 'في تقدم';

  @override
  String get ticket_severity_high => 'عالي';

  @override
  String get ticket_severity_low => 'منخفض';

  @override
  String get ticket_severity_medium => 'متوسط';

  @override
  String get we_are_sorry => 'نحن نعتذر';

  @override
  String get generic_error_message =>
      'التطبيق يواجه مشكلة, يرجى المحاولة مرة أخرى بعد بضع دقائق';

  @override
  String get try_again => 'حاول مجددا';

  @override
  String get internet_connection_error_title => 'خظأ اثناء الإتصال بالإنترنت';

  @override
  String get internet_connection_error_msg => 'خظأ اثناء الإتصال بالإنترنت';

  @override
  String get internet_connection_error_try_again_button =>
      'حاول مجددأ بعد الإتصال بشبكة الإنترنت';

  @override
  String get capture_image => 'التقط صوره';

  @override
  String get choose_from_gallery => 'اختر من المعرض';

  @override
  String get choose_media => 'اختر الوسائط';

  @override
  String get choose_media_description => 'اختر الوسائط المفضلة لديك';

  @override
  String get record_video => 'تسجيل الفيديو';

  @override
  String get choose_video_from_gallery => 'اختر فيديو من المعرض';

  @override
  String get permission_access_microphone_title => 'الوصول إلى الميكروفون';

  @override
  String get permission_access_microphone_message =>
      'نحتاج إلى الوصول إلى الميكروفون الخاص بك حتى نتمكن من تسجيل الملاحظات الصوتية!';

  @override
  String get permission_access_location_title => 'الوصول إلى الموقع';

  @override
  String get permission_access_location_message =>
      'نحتاج إلى الوصول إلى موقعك لاكتشاف منطقتك!';

  @override
  String get permission_access_camera_title => 'الوصول إلى الكاميرا';

  @override
  String get permission_access_camera_message =>
      'نحتاج إلى الوصول إلى الكاميرا حتى نتمكن من التقاط الصور!';

  @override
  String get permission_access_video_camera_message =>
      'نحتاج إلى الوصول إلى الكاميرا حتى نتمكن من التقاط الفيديو!';

  @override
  String get permission_access_gallery_title => 'الوصول إلى المعرض';

  @override
  String get permission_access_gallery_message =>
      'نحتاج إلى الوصول إلى معرض الصور الخاص بك حتى نتمكن من اختيار الصور!';

  @override
  String get permission_access_video_gallery_message =>
      'نحتاج إلى الوصول إلى معرض الصور الخاص بك حتى نتمكن من اختيار الفيديو!';

  @override
  String get permission_access_change_settings_button => 'تغيير الاعدادات';

  @override
  String get permission_access_dismiss_button => 'رفض';

  @override
  String get generic_pop_up_dismiss_button => 'رفض';

  @override
  String get error_dialog_header => 'فشلت عمليتك';

  @override
  String get dismiss => 'رفض';

  @override
  String get login_title => 'هيا بنا تبدأ';

  @override
  String get login_sub_title => 'سجل الدخول لتبدأ بالعمل على مهامك';

  @override
  String get sab_number => 'Sab-Number';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get invalid_sab => 'رمز التعريف يجب ان يتكون من ٦ ل ٨ ارقام';

  @override
  String get invalid_password => 'كلمة المرور يجبان لا تقل عن ٦ احرف';

  @override
  String get visits => 'زيارة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String welcome(Object user) {
    return 'Welcome, $user';
  }

  @override
  String get lets_get_to_work => 'هيا لنبدأ العمل ✍️';

  @override
  String get upcoming_visits => 'الزيارات القادمة';

  @override
  String get tasks => 'المهام';

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
  String get running => 'جاري';

  @override
  String get incomplete => 'غير مكتمل';

  @override
  String get completed => 'مكتمل';

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
  String get invalid_user_name => 'اسم المستخدم يجب ان لا يكون فارغ';

  @override
  String get invalid_phone_number => 'رقم الهاتف يجب ان يتكون من ١١ رقم';

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
  String get personal_info => 'المعلومات الشخصية';

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
      'يجب عليك تصوير الفرع حتي تتمكن من إتمام هذه العملية';

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
}
