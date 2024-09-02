import 'dart:io';

import 'package:blood_Bank/api/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importnace_channel", "High_imprtance_notification",
    importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> FirebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('A bg message just showerd up: ${message.messageId}');
}

class SendRequest extends StatefulWidget {
  final String passedBlood;
  final String passedCity;
  SendRequest({required this.passedBlood, required this.passedCity});
  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  String textValue = 'hello world';
  CollectionReference reference =
      FirebaseFirestore.instance.collection("Registration");

  @override
  void initState() {
    // configureFirebaseMessaging();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: "@mipmap/ic_launcher",
            )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('New onmessage was publish!!!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        String username = message.data['name'] ?? '';
        print("username:$username");
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name:$username'),
                      Text(notification.body!)
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    //bloodObject.createState().getCity();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text('Send Request'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: reference
                  .where('BloodGroup', isEqualTo: widget.passedBlood)
                  .where('City', isEqualTo: widget.passedCity)
                  .get()
                  .asStream(),
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (stream.hasError) {
                  return Center(child: Text(stream.error.toString()));
                }
                QuerySnapshot<Map<String, dynamic>> querySnapshot =
                    stream.data as QuerySnapshot<Map<String, dynamic>>;
                if (querySnapshot.size == 0) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.amber,
                        content: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'No Data Available For Blood Group ${widget.passedBlood} in City ${widget.passedCity}',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )));
                  });
                }

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: querySnapshot.size,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            (querySnapshot.docs[index]["imageUrl"] == "")
                                ? AssetImage("assets/images/Profile/pro.png")
                                    as ImageProvider<Object>?
                                : NetworkImage(
                                    querySnapshot.docs[index]["imageUrl"]),
                      ),
                      title: Text(querySnapshot.docs[index]["Name"]),
                      subtitle: Text(querySnapshot.docs[index]['City']),
                      trailing: IconButton(
                        onPressed: () async {
                          // showNotification();
                          setState(() {});
                          // flutterLocalNotificationsPlugin.show(
                          //     0,
                          //     "send Blood:${widget.passedBlood}",
                          //     "city:${widget.passedCity}",
                          //     NotificationDetails(
                          //         android: AndroidNotificationDetails(
                          //             channel.id, channel.name,
                          //             importance: Importance.high,
                          //             color: Colors.blue,
                          //             playSound: true,
                          //             icon: "@mipmap/ic_launcher")));
                          String ptoken =
                              querySnapshot.docs[index]['pushToken'];
                          print(ptoken);
                          String name = querySnapshot.docs[index]['Name'];
                          print(name);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Row(
                                children: [
                                  Icon(Icons.check),
                                  SizedBox(width: 8),
                                  Text(
                                    'Request sent successfully',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                          await APIs.sendPushNotification(
                              ptoken,
                              "Blood:${widget.passedBlood}",
                              "City:${widget.passedCity}",
                              "name:$name");
                        },
                        icon: Icon(CupertinoIcons.arrow_right),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
