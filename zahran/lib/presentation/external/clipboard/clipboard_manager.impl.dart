import 'package:flutter/services.dart';

import 'clipboard.manager.dart';

class ClipboardManagerImpl extends ClipboardManager {
  @override
  Future<void> setClipboardData({String? text}) {
    return Clipboard.setData(ClipboardData(text: text));
  }
}
