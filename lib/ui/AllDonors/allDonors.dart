import 'package:blood_Bank/ui/widgets/myAppBar.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:flutter/material.dart';

import '../../utils/Screen.dart';
import '../BloodRequest/myBloodCard.dart';

class UiAllDonors extends StatefulWidget {
  @override
  _UiAllDonorsState createState() => _UiAllDonorsState();
}

class _UiAllDonorsState extends State<UiAllDonors> {
  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
      appBar: myAppbar(
        title: myText(
          string: 'All Donors',
          fontColor: Colors.black54,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Screen.deviceHeight * 0.15,
              width: Screen.deviceWidth * 0.20,
              child: myBloodCard(
                bloodGroup: 'B+',
                bloodGroupInString: 'B Positive',
                imgPath: 'select2',
                selectedBorderColor: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Screen.deviceHeight * 0.020,
                bottom: Screen.deviceHeight * 0.015,
              ),
              child: myText(
                string: 'Your 25 request available !',
                fontColor: Colors.black54,
              ),
            ),
            Card(
              child: ListTile(
                title: myText(string: 'Name'),
                subtitle: myText(string: 'location'),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 20,
                ),
                trailing: myText(
                  string: '5Km',
                  bgcolor: Colors.deepPurple,
                  fontColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
