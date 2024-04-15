import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationScreen extends StatelessWidget {
  final RemoteMessage message;

  const NotificationScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${message.notification?.title}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Body: ${message.notification?.body}'),
            SizedBox(height: 16),
            Text('Data: ${message.data}'),
          ],
        ),
      ),
    );
  }
}
