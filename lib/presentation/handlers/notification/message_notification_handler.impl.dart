import 'package:meta/meta.dart';
import 'package:zahran/presentation/external/local_notification/local_notification.external.dart';
import 'package:zahran/presentation/navigation/named-navigator.dart';

import 'notification_handler.dart';

class MessageNotificationHandlerImpl extends NotificationHandler {
  final LocalNotification _localNotification;
  final NamedNavigator _namedNavigator;
  String _messageId;
  MessageNotificationHandlerImpl(
    Map<String, dynamic> notification,
    Map<String, dynamic> data,
    LocalNotification localNotification,
    NamedNavigator namedNavigator,
  )   : _namedNavigator = namedNavigator,
        _localNotification = localNotification,
        super(notification, data);

  @override
  void extractNotificationData(Map<String, dynamic> data) {
    _messageId = data['id'];
  }

  @override
  Future<void> onMessageNotification() async {
    await _localNotification.initialize();
    _localNotification.selectNotificationSubject.stream.listen((String payload) async {
      print("😭😭😭😭😭😭😭 Listen to notification click action with payload equal to: $payload");
      _namedNavigator.push(Routes.SPLASH_ROUTER, arguments: int.parse(_messageId));
    });
    if (title != null && body != null) {
      _localNotification.showSimpleNotification(title, body, "Add customer payload");
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

  void _navigateToOrder({@required bool onLaunch, @required bool replaceIfCurrent}) async {
    if (onLaunch) _namedNavigator.push(Routes.SPLASH_ROUTER, replace: true, clean: true);

    _namedNavigator.push(Routes.SPLASH_ROUTER, arguments: int.parse(_messageId), replaceIfCurrent: replaceIfCurrent);
  }
}
