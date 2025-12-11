import 'package:flutter/material.dart';
import 'package:new_project/main.dart';

class NotificationPage extends StatefulWidget {
    NotificationPayload ? notificationsPayload;
   NotificationPage({super.key,this.notificationsPayload});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Notifications"),
        ),
        body: Center(
            child: Text("Notification Screen"),
        ),
    );
  }
}