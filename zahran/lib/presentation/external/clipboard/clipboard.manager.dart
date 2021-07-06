import 'package:meta/meta.dart';

abstract class ClipboardManager {
  Future<void> setClipboardData({@required String text});
}
