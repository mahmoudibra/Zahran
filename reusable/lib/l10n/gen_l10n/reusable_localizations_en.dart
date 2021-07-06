
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'reusable_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for English (`en`).
class ReusableLocalizationsEn extends ReusableLocalizations {
  ReusableLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authorizationMessage => 'Sorry! You do not have permission to order this';

  @override
  String get connectionTimeOutMessage => 'Sorry! The process took too long.';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get error => 'Error';

  @override
  String get info => 'Info';

  @override
  String get loadDone => 'Load success';

  @override
  String get loadFailed => 'Load fail';

  @override
  String get loadMore => 'Load more';

  @override
  String get loading => 'Please wait ...';

  @override
  String get lock => 'Lock';

  @override
  String get noInternetMessage => 'Sorry! Cannot connect to the Internet. Check your internet quality.';

  @override
  String get noItems => 'Empty list';

  @override
  String get noMoreItems => 'No more items';

  @override
  String get notFoundMessage => 'Sorry! The link you requested does not exist';

  @override
  String get notSuccessResponse => 'Sorry! The operation failed. Please try again or contact the administration if there is a problem.';

  @override
  String get reload => 'Reload';

  @override
  String get requiredField => 'This field is required';

  @override
  String get show => 'Show';

  @override
  String get success => 'Success';

  @override
  String get unlock => 'Unlock';

  @override
  String get warning => 'Warning';
}
