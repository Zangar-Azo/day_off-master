import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/core/config/notifications.dart';

import '../../locator.dart';

class FirebaseMessagingNotification {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );

  AndroidNotificationChannel get channel => _channel;
  FirebaseMessaging get messaging => _messaging;

  FirebaseMessagingNotification();

  Future<void> registerNotification() async {
    // Initialize the Firebase app
    await Firebase.initializeApp();

    // On iOS, this helps to take the user permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    _messaging.getToken().then((token) {
      print("Token: $token");
    }).catchError((e) {
      print(e);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        sl<NotificationHandler>().showNotification(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            details: NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                playSound: true,
                icon: 'ic_launcher',
              ),
            ));
      }
    });
    sl<NotificationHandler>()
        .localNotifiactionPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> onClickNotificationView(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp event was published');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Text('qqqqq'),
                ));
      }
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('BG message just showed up: $message');
  }
}
