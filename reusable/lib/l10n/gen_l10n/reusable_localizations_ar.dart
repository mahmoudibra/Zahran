
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'reusable_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Arabic (`ar`).
class ReusableLocalizationsAr extends ReusableLocalizations {
  ReusableLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get authorizationMessage => 'عذرا! ليس لديك الصلاحية لهذا الأمر';

  @override
  String get connectionTimeOutMessage => 'عذرا! إستغرقت العملية وقت أطول من اللازم';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get error => 'خطأ';

  @override
  String get info => 'ملاحظة';

  @override
  String get loadDone => 'تم التحميل';

  @override
  String get loadFailed => 'فشل التحميل';

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String get loading => 'برجاء الإنتظار ...';

  @override
  String get lock => 'إيقاف';

  @override
  String get noInternetMessage => 'عذرا! لا يمكن الاتصال بالإنترنت تأكد من جودة الإنترنت لديك';

  @override
  String get noItems => 'القائمة فارغة';

  @override
  String get noMoreItems => 'إنتهت القائمة';

  @override
  String get notFoundMessage => 'عذرا! الرابط الذي طلبته غير موجود';

  @override
  String get notSuccessResponse => 'عذرا! فشلت العملية برجاء المحاولة مرة أخري أو الإتصال بالادارة في حال وجود مشكلة';

  @override
  String get reload => 'إعادة تحميل';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get show => 'عرض';

  @override
  String get success => 'تم';

  @override
  String get unlock => 'تفعيل';

  @override
  String get warning => 'تنبيه';
}
