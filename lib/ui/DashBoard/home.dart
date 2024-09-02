import 'package:blood_Bank/ui/DashBoard/dashBoard.dart';
import 'package:blood_Bank/ui/DashBoard/myDrawer.dart';
import 'package:blood_Bank/ui/profile/linfoUsers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

/// Drawer Controller
ZoomDrawerController zoomDrawerController = new ZoomDrawerController();

class UiHome extends StatefulWidget {
  @override
  _UiHomeState createState() => _UiHomeState();
}

class _UiHomeState extends State<UiHome> {
  @override
  void initState() {
    Info.getUser();
    zoomDrawerController.stateNotifier?.addListener(() {
      setState(() {});
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[500],
      body: ZoomDrawer(
        controller: zoomDrawerController,

        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,

        style: DrawerStyle.defaultStyle,
        //  backgroundColor: Colors.white,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
        mainScreen: UiDashBoard(),
        menuScreen: MyDrawer(),
      ),
    );
  }
}
