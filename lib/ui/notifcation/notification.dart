import 'package:blood_Bank/ui/BloodRequest/sendRequest.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UiNotification extends StatefulWidget {
  @override
  _UiNotificationState createState() => _UiNotificationState();
}

class _UiNotificationState extends State<UiNotification> {
  String title = 'title';
  String helper = 'helper';
  int _counter = 0;
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: "@mipmap/ic_launcher")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(helper),
          ),
          CupertinoButton(
            color: Colors.pink[200],
            child: Text('send'),
            onPressed: () {
              print('something');
              showNotification();

              ///send a message or notification on click
            },
          ),
        ],
      ),
    );
  }
}
