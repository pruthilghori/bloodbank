import 'dart:developer';

import 'package:blood_Bank/api/api.dart';
import 'package:blood_Bank/ui/BloodRequest/sendRequest.dart';
import 'package:blood_Bank/ui/DashBoard/home.dart';
import 'package:blood_Bank/ui/FindDonor/findDonor.dart';
import 'package:blood_Bank/ui/login/login.dart';
import 'package:blood_Bank/ui/splashScreen/SplashScreen.dart';
import 'package:blood_Bank/utils/myTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(FirebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  SharedPreferences pref = await SharedPreferences.getInstance();
  String? letBeginCheck = pref.getString('letBeging');
  String? loginCheck = pref.getString('login');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  set();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeEnable ? ThemeData.dark() : ThemeData.light(),
      home: letBeginCheck == 'done'
          ? loginCheck == 'loginDone'
              ? UiHome()
              : UiLoginScreen()
          : UiSplashScreen(),
    ),
  );
}
