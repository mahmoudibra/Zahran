import 'package:zahran/presentation/external/local_notification/local_notification.external.dart';
import 'package:zahran/presentation/handlers/notification/push_notification_types.dart';
import 'message_notification_handler.impl.dart';
import 'notification_handler.dart';
import 'notification_handler_factory.dart';

class NotificationHandlerFactoryImpl extends NotificationHandlerFactory {
  NotificationHandler getNotificationHandler(Map<String, dynamic> message) {
    String notificationType = "";
    Map<String, dynamic> data = {};
    Map<String, dynamic> notification = {};

    if (message['notification'] != null) {
      // extracting title and body directly from notification field if OS is (Android)
      notification = new Map<String, dynamic>.from(message['notification']);

      print("🚀🚀🚀🚀🚀🚀 Android Notification payload is: $notification");
    } else if (message['aps'] != null) {
      // extracting title and body throw aps then alert if OS is (IOS)
      Map<String, dynamic> aps = new Map<String, dynamic>.from(message['aps']);
      notification = new Map<String, dynamic>.from(aps['alert']);

      print("🚀🚀🚀🚀🚀🚀 IOS Notification payload is: $notification");
    }

    if (message['data'] != null) {
      // extracting notification data content directly from data field if OS is (Android)
      data = new Map<String, dynamic>.from(message['data'] ?? message);
      print("🚀🚀🚀🚀🚀🚀 Android Data Payload: $data");

      notificationType = data['notification_type'];
    } else {
      // we don't have to extract notification data content in IOS as it should equal notification message.
      data = message;
      print("🚀🚀🚀🚀🚀🚀 IOS Data Payload: $data");

      notificationType = message['notification_type'];
    }

    if (notificationType == PushNotificationTypes.MESSAGE.value) {
      return MessageNotificationHandlerImpl(
          notification, data, LocalNotification());
    }
    // Return null for marketing notification(without data section) which send from console
    return null;
  }
}
