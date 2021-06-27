import 'notification_handler.dart';

abstract class NotificationHandlerFactory {
  NotificationHandler getNotificationHandler(Map<String, dynamic> message);
}
