import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_demo/main.dart';

import '../screens/notification_screen.dart';

class NotificationController {
  static onMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    MyApp.navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => NotificationScreen(message: message), // Notice the named parameter 'message' is now used
      ),
          (route) => route.isFirst,
    );
  }

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
}