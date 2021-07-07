import 'package:meta/meta.dart';
import 'package:zahran/presentation/external/local_notification/local_notification.external.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'notification_handler.dart';

class MessageNotificationHandlerImpl extends NotificationHandler {
  final LocalNotification _localNotification;
  String _messageId;
  MessageNotificationHandlerImpl(
    Map<String, dynamic> notification,
    Map<String, dynamic> data,
    LocalNotification localNotification,
  )   : _localNotification = localNotification,
        super(notification, data);

  @override
  void extractNotificationData(Map<String, dynamic> data) {
    _messageId = data['id'];
  }

  @override
  Future<void> onMessageNotification() async {
    await _localNotification.initialize();
    _localNotification.selectNotificationSubject.stream
        .listen((String payload) async {
      print(
          "😭😭😭😭😭😭😭 Listen to notification click action with payload equal to: $payload");
      ScreenNames.splash.push(int.parse(_messageId));
    });
    if (title != null && body != null) {
      _localNotification.showSimpleNotification(
          title, body, "Add customer payload");
    }
  }

  @override
  void onResumeNotification() {
    _navigateToOrder(onLaunch: false, replaceIfCurrent: true);
  }

  @override
  void onLaunchNotification() {
    _navigateToOrder(onLaunch: true, replaceIfCurrent: false);
  }

  void _navigateToOrder(
      {@required bool onLaunch, @required bool replaceIfCurrent}) async {
    if (onLaunch) ScreenNames.splash.pushAndRemoveAll();
    if (replaceIfCurrent)
      ScreenNames.splash.pushAndRemoveAll(int.parse(_messageId));
    else
      ScreenNames.splash.push(int.parse(_messageId));
  }
}
