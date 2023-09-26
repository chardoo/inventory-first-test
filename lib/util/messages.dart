import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void OnMessageRecieved() async {
    //   messag
     FirebaseMessaging.onMessage.listen((message) { 
      print("mesaage is here man fore", );
      print(message);
          display(message);
     });
    //  FirebaseMessaging.onBackgroundMessage((message) {
    //     display(message);
    //  });

  }

  static Future<void> display(RemoteMessage message) async {
    // To display the notification in device
    try {
      print(message.notification!.android!.sound);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              message.notification!.android!.sound ?? "Channel Id",
              message.notification!.android!.sound ?? "Main Channel",
              groupKey: "gfg",
              color: Colors.green,
              importance: Importance.max,
              sound: RawResourceAndroidNotificationSound(
                  message.notification!.android!.sound ?? "gfg"),

              // different sound for
              // different notification
              playSound: true,
              priority: Priority.high),
          iOS: const DarwinNotificationDetails(
              presentAlert: true, presentSound: true, presentBadge: true));
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
