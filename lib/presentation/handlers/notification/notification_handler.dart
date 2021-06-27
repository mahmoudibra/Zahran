abstract class NotificationHandler {
  String title;
  String body;

  NotificationHandler(
      Map<String, dynamic> notification, Map<String, dynamic> data) {
    if (notification != null) {
      title = notification["title"];
      body = notification["body"];
    }
    extractNotificationData(data);
  }

  void extractNotificationData(Map<String, dynamic> data);

  void onMessageNotification();

  void onResumeNotification();

  void onLaunchNotification();
}
