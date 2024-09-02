import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class APIs {
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  // static String? pushToken;

  // static Future<void> getFirebaseMessaginToken() async {
  //   await fMessaging.requestPermission();

  //   await fMessaging.getToken().then((t) {
  //     if (t != null) {
  //       pushToken = t;
  //       log("Push Token:$t");
  //     }
  //   });
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     log("Got a Message In background");
  //     log("Message Data: ${message.data}");

  //     if (message.notification != null) {
  //       log("Message also contained a Notificatiions: ${message.notification}");
  //     }
  //   });
  // }

  //api called push notification automatically
  // for sending push notification
  static Future<void> sendPushNotification(
      String token, String blood, String city, String name) async {
    try {
      final body = {
        "to": token,
        "notification": {
          "title": blood, //our name should be send
          "body": city,
          "android_channel_id": "chats"
        },
        "data": {"name": name}
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAXlsXLMg:APA91bHIqGJEdCucbWSoGQQJniE46FcUEbM-1O9sVvQN_RMBRsDys8wm4oiKrlm1InxB4Zkz0a2IKQ_w0CuAZe1l_zQb4ibsMl5BBf2s7xaKFt-D_cnSkTDFsuz6e_vtn-c8XwQ8_cCc'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}
