import 'dart:math';

import 'package:blood_Bank/model/userData.dart';
import 'package:blood_Bank/ui/BloodBank/finalBloodBank.dart';
import 'package:blood_Bank/ui/BloodRequest/bloodRequest.dart';
import 'package:blood_Bank/ui/DashBoard/home.dart';
import 'package:blood_Bank/ui/DonorMap/DonorMap.dart';
import 'package:blood_Bank/ui/FeedBack/Feedbackform.dart';
import 'package:blood_Bank/ui/FindDonor/findDonor.dart';
import 'package:blood_Bank/ui/Guidelines_for_Donation/GuidelinesForDonation.dart';
import 'package:blood_Bank/ui/blog/blog.dart';
import 'package:blood_Bank/ui/login/login.dart';
import 'package:blood_Bank/ui/notifcation/notification.dart';
import 'package:blood_Bank/ui/profile/linfoUsers.dart';
import 'package:blood_Bank/ui/profile/profile.dart';
import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  // MyDrawer(
  //     {required this.userEmail, required this.userImg, required this.userName});
  // String userImg;
  // String userName;
  // String userEmail;
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<MyDrawerModel> drawerDataList = [
    MyDrawerModel(
      name: 'Search Donor',
      iconData: CupertinoIcons.search,
      onClick: UiFindDonor(),
    ),
    MyDrawerModel(
      name: 'Blood Request',
      iconData: Icons.stacked_bar_chart,
      onClick: UiBloodRequest(),
    ),
    MyDrawerModel(
      name: 'Blood Bank',
      iconData: CupertinoIcons.house,
      onClick: UiBloodBank(),
    ),
    MyDrawerModel(
      name: 'Notification',
      iconData: CupertinoIcons.bell,
      onClick: UiNotification(),
    ),
    MyDrawerModel(
      name: 'Blog',
      iconData: CupertinoIcons.app_badge,
      onClick: UiBlog(),
    ),
    MyDrawerModel(
      name: 'Guidelines for Donation',
      iconData: CupertinoIcons.book,
      onClick: UiGuidelines(),
    ),
    MyDrawerModel(
      name: 'All Donor Map',
      iconData: CupertinoIcons.map,
      onClick: UiDonorMap(),
    ),
    MyDrawerModel(
      name: 'FeedBack',
      iconData: Icons.feedback,
      onClick: FeedbackForm(),
    ),
  ];

  String userName = '', userUrl = '', userEmail = '';
  bool isLoading = true;

  Future getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('Name') ?? '';
    print("user:$userName");
    userUrl = pref.getString('ProfileUrl') ?? '';
    print("useriml:$userUrl");
    userEmail = pref.getString('Email') ?? '';
    print("email:$userEmail");
    setState(() {});
  }

  Future loaddata() async {
    await Info.getUser();
    await getUserData();
    setState(() {
      isLoading = false;
    });
  }

  UserData? _user;

  @override
  void initState() {
    loaddata();
    print("Init call");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    //Info.getUser();
    print("Hello beta:$Info");

    return Container(
      // color: Colors.pink[200],
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.shade200,
            Colors.pink.shade100,
            Colors.pink.shade100,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Screen.deviceHeight * 0.05),
          UserAccountsDrawerHeader(
            margin: EdgeInsets.symmetric(
              horizontal: 6,
            ),
            onDetailsPressed: () {
              zoomDrawerController.close!();
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => UiProfile(),
                ),
              );
            },
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.pink,
                  Colors.pink.shade100,
                  //  Colors.pink[100]
                ]),
                border: Border(
                    bottom: BorderSide(color: Colors.black45, width: 3))),
            // currentAccountPicture: CircleAvatar(
            //   radius: 70,
            //   backgroundImage: NetworkImage(Info.url),
            // ),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(Screen.deviceHeight * 1),
              child: CachedNetworkImage(
                imageUrl: Info.url,
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    CircleAvatar(child: Icon(CupertinoIcons.person)),
                fit: BoxFit.cover,
              ),
            ),

            accountName: myText(string: Info.currentUser
                // string: Info.currentUser ?? 'user name',
                // fontColor: Colors.black87,
                ),
            accountEmail: myText(
              string: Info.userEmail,
              //string: Info.userEmail ?? 'user email',
              // fontColor: Colors.black87,
            ),
          ),
          SizedBox(height: Screen.deviceHeight * 0.02),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: drawerDataList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  hoverColor: Colors.black12,
                  leading: Icon(
                    drawerDataList[index].iconData,
                    color: Colors.black,
                  ),
                  title: myText(
                    string: drawerDataList[index].name,
                    fontColor: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    zoomDrawerController.close!();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => drawerDataList[index].onClick,
                      ),
                    );
                    print('${drawerDataList[index].onClick}');
                  },
                );
              },
            ),
          ),
          // ListTile(
          //   leading: Icon(CupertinoIcons.power),
          //   title: Text('Logout'),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       CupertinoPageRoute(
          //         builder: (context) => UiLoginScreen(),
          //       ),
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UiLoginScreen(),
                  ),
                );
              },
              child: myContainer(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                containerBorder: Border.all(
                  color: Colors.pink,
                  width: 2,
                ),
                child: myText(
                  string: 'Logout',
                  fontColor: Colors.pink,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                containerBorderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawerModel {
  String name;
  Widget onClick;
  IconData iconData;

  MyDrawerModel(
      {required this.name, required this.onClick, required this.iconData});
}
