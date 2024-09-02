import 'package:blood_Bank/ui/DashBoard/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

ZoomDrawerController _zoomDrawerController = new ZoomDrawerController();

class DemoZoomDrawer extends StatefulWidget {
  @override
  _DemoZoomDrawerState createState() => _DemoZoomDrawerState();
}

class _DemoZoomDrawerState extends State<DemoZoomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[500],
      body: ZoomDrawer(
        controller: _zoomDrawerController,
        // style: DrawerStyle.DefaultStyle,
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        // backgroundColor: Colors.pink[300],
        slideWidth: MediaQuery.of(context).size.width * 0.45,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
        mainScreen: DemoClass(),
        menuScreen: MyDrawer(),
      ),
    );
  }
}

class DemoClass extends StatefulWidget {
  @override
  _DemoClassState createState() => _DemoClassState();
}

class _DemoClassState extends State<DemoClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () {
            _zoomDrawerController.toggle!();
          },
        ),
        title: Text('dashboard'),
      ),
      body: Center(
        child: Text('dashboard content'),
      ),
    );
  }
}
