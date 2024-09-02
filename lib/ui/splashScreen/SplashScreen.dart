import 'dart:async';

import 'package:blood_Bank/LocalData/onBording.dart';
import 'package:blood_Bank/ui/onBording/onBoarding.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/material.dart';

class UiSplashScreen extends StatefulWidget {
  @override
  _UiSplashScreenState createState() => _UiSplashScreenState();
}

class _UiSplashScreenState extends State<UiSplashScreen> {
  final splashDelay = 5;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    setletBegin();
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => UiOnBoarding()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/blood_SplashScreen.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
