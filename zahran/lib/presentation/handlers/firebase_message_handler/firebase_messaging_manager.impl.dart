import 'package:zahran/presentation/handlers/notification/notification_handler_factory.dart';
import 'package:zahran/presentation/handlers/notification/notification_handler_factory.impl.dart';

import 'firebase_messaging_manager.dart';

class FirebaseMessagingManagerImpl extends FirebaseMessagingManager {
  // final FirebaseMessaging _firebaseMessaging =  FirebaseMessaging();
  final NotificationHandlerFactory _notificationHandlerFactory = NotificationHandlerFactoryImpl();

  @override
  void initialize() {
    //TODO: initialize firebase message
    // FirebaseMessaging.onMessage.listen((message) {
    //   _notificationHandlerFactory.getNotificationHandler(message)?.onMessageNotification();
    // });
    //
    // _firebaseMessaging.configure(
    //     onMessage: (Map<String, dynamic> message) async =>
    //    ,
    //     onLaunch: (Map<String, dynamic> message) async =>
    //         _notificationHandlerFactory.getNotificationHandler(message)?.onLaunchNotification(),
    //     onResume: (Map<String, dynamic> message) async =>
    //         _notificationHandlerFactory.getNotificationHandler(message)?.onResumeNotification());
    //
    // _firebaseMessaging.requestPermission(IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {});
  }

  @override
  Future<String> getToken() {
    //TODO: update get token
    // return _firebaseMessaging.getToken();
  }
}
