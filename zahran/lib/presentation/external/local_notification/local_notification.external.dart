import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotification {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // ignore: close_sinks
  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  // ignore: close_sinks
  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();
  String selectedNotificationPayload;
  String initialRoute;

  Future<void> initialize() async {
    //TODO: initialize Local notification
    // try {
    //   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("app_icon");
    //   final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    //       requestAlertPermission: false,
    //       requestBadgePermission: false,
    //       requestSoundPermission: false,
    //       onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
    //         didReceiveLocalNotificationSubject
    //             .add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
    //       });
    //
    //   final InitializationSettings initializationSettings =
    //       InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    //
    //   final NotificationAppLaunchDetails notificationAppLaunchDetails =
    //       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    //
    //   if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //     selectedNotificationPayload = notificationAppLaunchDetails.payload;
    //     initialRoute = Routes.SPLASH_ROUTER;
    //   }
    //
    //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //       onSelectNotification: (String payload) async {
    //     if (payload != null) {
    //       print("🚀 🚀 🚀 🚀 Notification payload is not null and equal to: $payload");
    //     }
    //     selectedNotificationPayload = payload;
    //     selectNotificationSubject.add(payload);
    //   });
    //   _configurePermission();
    // } catch (error) {
    //   print("🚀 🚀 🚀Error while initialize notification: $error");
    //   rethrow;
    // }
  }

  //_configurePermission() {
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
  //     ?.requestPermissions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  // }

  showSimpleNotification(String title, String message, String payload) async {
    // AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //     'your channel id', 'your channel name', 'your channel description',
    //     importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    // NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.show(0, title, message, platformChannelSpecifics, payload: payload);
  }
}

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}
