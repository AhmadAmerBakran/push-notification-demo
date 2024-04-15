import 'package:firebase_messaging/firebase_messaging.dart';
import '../controllers/notification_controller.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  List<RemoteMessage> messages = []; // List to store incoming notifications

  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    print('FCM Token: $token');
    return token;
  }

  Future<bool> requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void setupCallbacks() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      messages.add(message); // Store the message
      NotificationController.onMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(NotificationController.onBackgroundMessage);

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      messages.add(initialMessage); // Store the initial message
      NotificationController.onMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      messages.add(message); // Store the message triggered by app opening
      NotificationController.onMessage(message);
    });
  }

  Stream<String?> get tokenStream async* {
    yield await messaging.getToken();
    yield* messaging.onTokenRefresh;
  }

  List<RemoteMessage> getNotifications() {
    return messages;
  }
}
