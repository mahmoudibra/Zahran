


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
  String get generic_error_message => 'التطبيق يواجه مشكلة, يرجى المحاولة مرة أخرى بعد بضع دقائق';

  @override
  String get try_again => 'حاول مجددا';

  @override
  String get internet_connection_error_title => 'خظأ اثناء الإتصال بالإنترنت';

  @override
  String get internet_connection_error_msg => 'خظأ اثناء الإتصال بالإنترنت';

  @override
  String get internet_connection_error_try_again_button => 'حاول مجددأ بعد الإتصال بشبكة الإنترنت';

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
  String get permission_access_microphone_message => 'نحتاج إلى الوصول إلى الميكروفون الخاص بك حتى نتمكن من تسجيل الملاحظات الصوتية!';

  @override
  String get permission_access_location_title => 'الوصول إلى الموقع';

  @override
  String get permission_access_location_message => 'نحتاج إلى الوصول إلى موقعك لاكتشاف منطقتك!';

  @override
  String get permission_access_camera_title => 'الوصول إلى الكاميرا';

  @override
  String get permission_access_camera_message => 'نحتاج إلى الوصول إلى الكاميرا حتى نتمكن من التقاط الصور!';

  @override
  String get permission_access_video_camera_message => 'نحتاج إلى الوصول إلى الكاميرا حتى نتمكن من التقاط الفيديو!';

  @override
  String get permission_access_gallery_title => 'الوصول إلى المعرض';

  @override
  String get permission_access_gallery_message => 'نحتاج إلى الوصول إلى معرض الصور الخاص بك حتى نتمكن من اختيار الصور!';

  @override
  String get permission_access_video_gallery_message => 'نحتاج إلى الوصول إلى معرض الصور الخاص بك حتى نتمكن من اختيار الفيديو!';

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
  String get personal_info => 'المعلومات الشخصية';

  @override
  String get sab_number => 'Sab-Number';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get inavlid_sab => 'رمز التعريف يجب ان يتكون من ٦ ل ٨ ارقام';

  @override
  String get inavlid_password => 'كلمة المرور يجبان لا تقل عن ٦ احرف';

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
  String get running => 'جاري';

  @override
  String get incomplete => 'غير مكتمل';

  @override
  String get completed => 'مكتمل';

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
}
