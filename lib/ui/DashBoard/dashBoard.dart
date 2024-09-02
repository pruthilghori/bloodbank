import 'package:blood_Bank/ui/BloodBank/finalBloodBank.dart';
import 'package:blood_Bank/ui/BloodRequest/ModelClass.dart';
import 'package:blood_Bank/ui/BloodRequest/bloodRequest.dart';
import 'package:blood_Bank/ui/DashBoard/home.dart';
import 'package:blood_Bank/ui/FindDonor/findDonor.dart';
import 'package:blood_Bank/ui/Guidelines_for_Donation/GuidelinesForDonation.dart';
import 'package:blood_Bank/ui/profile/profile.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'myCardContainer.dart';

class UiDashBoard extends StatefulWidget {
  @override
  _UiDashBoardState createState() => _UiDashBoardState();
}

class _UiDashBoardState extends State<UiDashBoard>
    with SingleTickerProviderStateMixin {
  List listPage = [
    UiFindDonor(),
    UiProfile(),
    UiBloodRequest(),
    UiFindDonor(),
    UiGuidelines()
  ];

  void test(testPage) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => testPage,
      ));

  List<DataModel> draw = [
    DataModel(dicon: Icons.search, dtxt: 'Search Donor'),
    DataModel(dicon: Icons.border_color, dtxt: 'My Profile'),
    DataModel(dicon: Icons.notifications, dtxt: 'Notification'),
    DataModel(dicon: Icons.calendar_today, dtxt: 'Select Blood Group'),
    DataModel(dicon: Icons.book, dtxt: 'Guidelines for Donation'),
  ];

  Widget draWidget(demo, i) {
    return ListTile(
      leading: Icon(
        draw[i].dicon,
        color: Colors.pink[300],
      ),
      title: InkWell(
        onTap: () {
          test(listPage[i]);
        },
        child: Text(
          draw[i].dtxt!,
          style: TextStyle(fontSize: 13, color: Colors.pink[300]),
        ),
      ),
    );
  }

  final FirebaseFirestore fb = FirebaseFirestore.instance;

  Future<QuerySnapshot> getImages() async {
    try {
      return await fb.collection("Images").get();
    } catch (e) {
      print("Error getting images: $e");
      throw e; // Rethrow the exception or handle it accordingly
    }
  }

  bool isExpanded = true;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      reverseDuration: Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        //elevation: 0,
        leading: IconButton(
          onPressed: () {
            zoomDrawerController.toggle!();
            setState(() {
              isExpanded
                  ? _animationController!.forward()
                  : _animationController!.reverse();
              isExpanded = !isExpanded;
            });
          },
          icon: AnimatedIcon(
            progress: _animationController!,
            icon: AnimatedIcons.menu_home,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 135,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.pink[400],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
              border: Border.all(
                color: Colors.pink.shade400,
              ),
            ),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                  child: myText(
                    string: 'GIVE THE GIFT OF LIFE',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Donate ',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Blood ',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            // overflow: Overflow.visible,
            children: [
              Container(
                height: Screen.deviceHeight / 1.515,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink[400],
                  border: Border.all(
                    color: Colors.pink[400]!,
                  ),
                ),
              ),
              Container(
                height: Screen.deviceHeight / 1.515,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(100)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Screen.deviceHeight * 0.038,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UiFindDonor(),
                                ));
                          },
                          child: myCardContainer(
                            circleAvatarBgColor: Colors.pink[300]!,
                            circleAvatarIcon: CupertinoIcons.search,
                            circleAvatarIconColor: Colors.pink[50]!,
                            typeString: 'Find Donor',
                            typeValueString: '235k',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UiBloodRequest(),
                                ));
                          },
                          child: myCardContainer(
                            circleAvatarBgColor: Colors.lightBlue[400]!,
                            circleAvatarIconColor: Colors.lightBlue[50]!,
                            circleAvatarIcon:
                                Icons.notifications_active_outlined,
                            typeString: 'Blood Request',
                            typeValueString: '500k',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screen.deviceHeight / 39.27,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => UiBloodBank()));
                          },
                          child: myCardContainer(
                            circleAvatarBgColor: Colors.blueGrey[300]!,
                            circleAvatarIcon: CupertinoIcons.drop,
                            circleAvatarIconColor: Colors.grey[50]!,
                            typeString: 'Blood Bank',
                            typeValueString: 'Map',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UiProfile(),
                              ),
                            );
                          },
                          child: myCardContainer(
                            circleAvatarBgColor: Colors.green[300]!,
                            circleAvatarIcon: Icons.person_outline,
                            circleAvatarIconColor: Colors.green[50]!,
                            typeString: 'Profile',
                            typeValueString: 'more',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Screen.deviceHeight / 39.27),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UiGuidelines(),
                            ));
                      },
                      child: Container(
                        width: Screen.deviceWidth / 1.16,
                        height: Screen.deviceHeight / 7.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.pink[50],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.purple[300],
                              child: Icon(
                                Icons.integration_instructions_outlined,
                                color: Colors.purple[50],
                              ),
                            ),
                            myText(string: 'Guidelines For Donation')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
