import 'dart:math';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UiDonorMap extends StatefulWidget {
  @override
  _UiDonorMapState createState() => _UiDonorMapState();
}

class _UiDonorMapState extends State<UiDonorMap> {
  CameraPosition _myPosition =
      CameraPosition(target: LatLng(21.228125, 72.833771), zoom: 10.0);

  final List<Marker> _listMarker = [];

  GoogleMapController? _controller;
  late BitmapDescriptor _markerIcon;

  void loadMarkerIcon() async {
    final ImageConfiguration config = createLocalImageConfiguration(context);
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        config, 'assets/your_marker_icon.png');
  }

  addMarker(
      {required LatLng cordinate,
      required String name,
      required String bloodGroup}) {
    int id = Random().nextInt(100);
    setState(
      () {
        _listMarker.add(
          Marker(
              markerId: MarkerId(id.toString()),
              position: cordinate,
              // icon: _markerIcon,
              infoWindow: InfoWindow(
                  title: name, snippet: bloodGroup, anchor: Offset(1, 1))),
        );
      },
    );
  }

  getUserMarkers() {
    FirebaseFirestore.instance.collection('Registration').get().then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
          (element) {
            try {
              if (element['showLocation'] == true) {
                addMarker(
                    cordinate:
                        LatLng(element['latitude'], element['longitude']),
                    name: element['Name'],
                    bloodGroup: element['BloodGroup']);
              }
            } catch (e) {
              print("Error parsing user location: $e");
            }
          },
        );
      },
    );
  }

  // void getCurrentLocation() async {
  //   var postition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   var lastPosition = await Geolocator.getLastKnownPosition();
  //   print('last position $lastPosition');

  //   setState(() {
  //     _myPosition = CameraPosition(
  //         target: LatLng(postition.latitude, postition.longitude));
  //     addMarker(LatLng(postition.latitude, postition.longitude));
  //   });
  // }
  // void getCurrentLocation() async {
  //   try {
  //     var position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );

  //     var lastPosition = await Geolocator.getLastKnownPosition();
  //     print('last position $lastPosition');

  //     setState(() {
  //       _myPosition = CameraPosition(
  //         target: LatLng(position.latitude, position.longitude),
  //       );
  //       // addMarker(LatLng(,position.latitude, position.longitude));
  //     });
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }

  @override
  void initState() {
    getUserMarkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: myText(
          string: 'All Donor Map',
          fontColor: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: _myPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        markers: _listMarker.toSet(),
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onTap: (cordinate) {
          _controller!.animateCamera(CameraUpdate.newLatLng(cordinate));
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'zoomOut',
            mini: true,
            backgroundColor: Colors.pink[300],
            child: Icon(
              CupertinoIcons.zoom_out,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              _controller!.animateCamera(CameraUpdate.zoomOut());
            },
          ),
          SizedBox(height: 6),
          FloatingActionButton(
            heroTag: 'zoomIn',
            mini: true,
            backgroundColor: Colors.pink[300],
            child: Icon(
              CupertinoIcons.zoom_in,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              _controller!.animateCamera(CameraUpdate.zoomIn());
            },
          ),
        ],
      ),
    );
  }
}
