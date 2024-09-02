import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:blood_Bank/model/userData.dart';
import 'package:blood_Bank/ui/profile/EditProfile.dart';
import 'package:blood_Bank/ui/profile/linfoUsers.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProfile extends StatefulWidget {
  @override
  _UiProfileState createState() => _UiProfileState();
}

class ProfileCurved extends CustomPainter {
  ProfileCurved({required this.color, required this.avtarRadius});

  final Color color;
  final double avtarRadius;

  void _drawbackground(Canvas canvas, Rect shapBounds, Rect avtarBounds) {
    final paint = Paint()..color = color;
    final backGroundPath = Path()
      ..moveTo(shapBounds.left, shapBounds.right)
      ..lineTo(shapBounds.bottomLeft.dx, shapBounds.bottomLeft.dy)
      ..arcTo(avtarBounds, -pi, pi, false)
      ..lineTo(shapBounds.bottomRight.dx, shapBounds.bottomRight.dy)
      ..lineTo(shapBounds.topRight.dx, shapBounds.topRight.dy)
      ..close();
    canvas.drawPath(backGroundPath, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final shapBounds =
        Rect.fromLTRB(0, 0, size.width, size.height - avtarRadius);
    final paint = Paint()..color = color;
    canvas.drawRect(shapBounds, paint);
    final centerAvtar = Offset(shapBounds.center.dx, shapBounds.bottom);
    final avtarBounds =
        Rect.fromCircle(center: centerAvtar, radius: avtarRadius).inflate(7);
    _drawbackground(canvas, shapBounds, avtarBounds);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _UiProfileState extends State<UiProfile> {
  static String? link;
  CollectionReference referenceRegistration =
      FirebaseFirestore.instance.collection("Registration");
  String? idUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  //function b
  final picker = ImagePicker();
  File? _imageFile;
  bool availableForDonate = false;
  bool userLocation = false;

  Future<void> uploadImageToFirebase(BuildContext context) async {
    try {
      Info.getUser();
      Reference storageReference = FirebaseStorage.instance.ref();
      String fileName = basename(_imageFile!.path);
      Reference firebaseStorageRef =
          storageReference.child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);

      await uploadTask.whenComplete(() => print("*-------*-"));
      String link = await firebaseStorageRef.getDownloadURL();
      await updateUserData(link);
      setState(() {
        Info.url = link;
      });
      print("Image upload successful!");
    } catch (error) {
      print("Error uploading image: $error");
    }

    // taskSnapshot.ref.getDownloadURL().then(
    //   (value) {
    //     link = '$value';
    //     referenceRegistration.get().then((QuerySnapshot querySnapshot) {
    //       querySnapshot.docs.forEach((element) {
    //         if (element["Email"] == FirebaseAuth.instance.currentUser!.email) {
    //           idUser = element.id;
    //           print(idUser);
    //           referenceRegistration.doc(idUser).update({'imageUrl': link}).then(
    //               (value) => print("success.."));
    //         }
    //       });
    //     });
    //   },
    // );
  }

  Future<void> updateUserData(String imageUrl) async {
    referenceRegistration.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element["Email"] == FirebaseAuth.instance.currentUser!.email) {
          String idUser = element.id;
          print(idUser);
          referenceRegistration.doc(idUser).update({'imageUrl': imageUrl}).then(
              (value) => print("User data updated successfully."));
        }
      });
    });
  }

  ///get current user location
  void getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lastPosition = await Geolocator.getLastKnownPosition();
      print('last position $lastPosition');
      print('current user id : ${Info.userId}');
      referenceRegistration.doc(Info.userId).update({
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
    } else {
      print("Location permission Denied");
    }
  }

  SharedPreferences? pref;
  String? name, email, city, profileUrl;

  setUserData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref!.getString('Name');
      email = pref!.getString('Email');
      city = pref!.getString('City');
      profileUrl = pref!.getString('ProfileUrl');
    });
  }

  UserData? _user;

  @override
  void initState() {
    setUserData();
    Info.getUser();
    // setState(() {
    //   userLocation = Info.userShowLocation;
    // });

    _user = UserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    Info.getUser();
    return Scaffold(
      backgroundColor: Colors.pink[400],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Screen.deviceHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Stack(
                  // overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: Screen.deviceHeight / 1.20,
                      width: Screen.deviceWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 145,
                              ),
                              Text(
                                //_user.getName ?? 'name',
                                Info.currentUser,
                                //   name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                // _user.getEmail ?? 'email',
                                Info.userEmail,
                                // email,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 3,
                                child: Container(
                                  height: 90,
                                  width: Screen.deviceWidth / 2.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.pink[50]),
                                        child: Icon(
                                          CupertinoIcons.drop,
                                          color: Colors.pink,
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "BloodGroup",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              Info.userBlood,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                child: Container(
                                  height: 90,
                                  width: Screen.deviceWidth / 2.1,
                                  decoration: BoxDecoration(
                                      //color: Colors.white
                                      // color: Color(0xFFf4f8fb),
                                      ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green[100]),
                                        child: Icon(
                                          CupertinoIcons.phone_fill,
                                          color: Colors.green,
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Mobile No",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              Info.phoneNo,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Card(
                          //   elevation: 3,
                          //   child: ListTile(
                          //     leading: Icon(
                          //       CupertinoIcons.drop,
                          //       size: 36,
                          //       color: Colors.pink[400],
                          //     ),
                          //     title: myText(
                          //       string: 'Blood Group',
                          //       fontSize: 18,
                          //     ),
                          //     trailing:
                          //         myText(string: Info.userBlood, fontSize: 18),
                          //   ),
                          // ),
                          // Card(
                          //   elevation: 3,
                          //   child: ListTile(
                          //     leading: Icon(
                          //       CupertinoIcons.phone_circle,
                          //       size: 36,
                          //       color: Colors.pink[400],
                          //     ),
                          //     title: myText(
                          //       string: 'Phone No',
                          //       fontSize: 18,
                          //     ),
                          //     trailing:
                          //         myText(string: Info.phoneNo, fontSize: 18),
                          //   ),
                          // ),
                          Card(
                            elevation: 3,
                            child: ListTile(
                              leading: myText(
                                  string: 'I am Available to Donate',
                                  fontSize: 16),
                              trailing: CupertinoSwitch(
                                  activeColor: Colors.pink[400],
                                  value: availableForDonate,
                                  onChanged: (value) {
                                    setState(() {
                                      availableForDonate = value;
                                    });
                                  }),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            child: ListTile(
                              leading: myText(
                                  string: 'Show My location to Other',
                                  fontSize: 16),
                              trailing: CupertinoSwitch(
                                activeColor: Colors.pink[400],
                                value: userLocation,
                                onChanged: (value) {
                                  setState(() {
                                    userLocation = value;
                                    if (value == true || userLocation == true) {
                                      getCurrentLocation();
                                    }
                                  });
                                  referenceRegistration
                                      .doc(Info.userId)
                                      .update({'showLocation': userLocation});
                                },
                              ),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            child: ListTile(
                              // minLeadingWidth: 0,
                              leading: Icon(
                                CupertinoIcons.calendar,
                                size: 30,
                              ),
                              title: myText(
                                string: 'Last Donation Date : ',
                                fontSize: 18,
                              ),
                              trailing: myText(
                                string: Info.lastDonationDate == 'No'
                                    ? 'Not Donated'
                                    : Info.lastDonationDate,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          CupertinoButton(
                            color: Colors.pink[400],
                            child: Text("Edit Profile"),
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              String? value = pref.getString('Email');
                              print("======${Info.userEmail}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: Screen.deviceHeight / 1.60,
                      child: Stack(
                          // overflow: Overflow.visible,
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(alignment: Alignment.bottomCenter, children: [
                              Positioned(
                                child: CustomPaint(
                                  size: Size(Screen.deviceWidth,
                                      Screen.deviceHeight / 1.27),
                                  painter: ProfileCurved(
                                      color: Colors.white, avtarRadius: 75),
                                ),
                                bottom: -22,
                              ),
                              // CircleAvatar(
                              //   radius: 62,
                              //   backgroundImage: (_imageFile == null)
                              //       ? NetworkImage(Info.url)
                              //           as ImageProvider<Object>?
                              //       : FileImage(_imageFile!),
                              // ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Screen.deviceHeight * 1),
                                child: CachedNetworkImage(
                                  imageUrl: Info.url,
                                  height: Screen.deviceHeight * 0.2,
                                  width: Screen.deviceHeight * 0.2,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                          child: Icon(CupertinoIcons.person)),
                                ),
                              ),
                            ]),
                            Positioned(
                                right: -04,
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    return showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      builder: (context) => Container(
                                        height: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      size: 50,
                                                      color: Colors.black54,
                                                    ),
                                                    onPressed: () async {
                                                      final selected =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera,
                                                              imageQuality: 80);

                                                      if (selected != null) {
                                                        setState(() {
                                                          _imageFile = File(
                                                              selected.path);
                                                        });
                                                      }
                                                      await uploadImageToFirebase(
                                                          context);
                                                      Navigator.pop(context);
                                                      ;
                                                    }),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.pink[300]),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.photo,
                                                      size: 50,
                                                      color: Colors.black54,
                                                    ),
                                                    onPressed: () async {
                                                      final selected =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                      if (selected != null) {
                                                        setState(() {
                                                          _imageFile = File(
                                                              selected.path);
                                                        });
                                                      }
                                                      await uploadImageToFirebase(
                                                          context);
                                                      Navigator.pop(context);
                                                    }),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.pink[300]),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  mini: true,
                                  backgroundColor: Colors.pink[300],
                                  child: Icon(
                                    CupertinoIcons.camera_fill,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ))
                          ]),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
