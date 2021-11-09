import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  FlutterLocalNotificationsPlugin get localNotifiactionPlugin =>
      _localNotificationsPlugin;

  NotificationHandler(this._localNotificationsPlugin);

  Future<void> initNotification() async {
    // android
    // icon of notification i guess, place it in @drawable folder
    var androidInitialize = AndroidInitializationSettings('ic_launcher');

    // ios
    var iOSInitialize = IOSInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({
    int id = 0,
    String title = 'Title of Notification',
    String body = 'Body',
    String subtext = '',
    NotificationDetails details,
    int seconds,
  }) async {
    var androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ongoing: true,
      subText: subtext,
      // icon on the trailing side of Notification
      // largeIcon: DrawableResourceAndroidBitmap('plant'),
    );

    var iOSDetails = IOSNotificationDetails();

    var platform = details == null
        ? NotificationDetails(android: androidDetails, iOS: iOSDetails)
        : details;

    if (seconds != null) {
      var scheduledNotificationDateTime =
          DateTime.now().add(Duration(seconds: seconds));
      return await _localNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledNotificationDateTime,
        platform,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
    }

    await _localNotificationsPlugin.show(id, title, body, platform);
  }
}
