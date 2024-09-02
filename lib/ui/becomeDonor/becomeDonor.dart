import 'package:blood_Bank/ui/BloodRequest/ModelClass.dart';
import 'package:blood_Bank/ui/BloodRequest/myBloodCard.dart';
import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/ui/widgets/myAppBar.dart';
import 'package:blood_Bank/ui/widgets/myField.dart';
import 'package:blood_Bank/ui/widgets/mySizedBox.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:blood_Bank/utils/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiBecomeDonor extends StatefulWidget {
  @override
  _UiBecomeDonorState createState() => _UiBecomeDonorState();
}

class _UiBecomeDonorState extends State<UiBecomeDonor> {
  bool _visibleContactNoForOthers = false;
  TextEditingController becomeDonorName = TextEditingController();
  TextEditingController becomeDonorEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(
        centerTitle: true,
        title: myText(
          string: 'Become Donor',
          fontColor: Colors.black45,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            mySizedBox(
              height: 230,
              child: Image.asset(
                'assets/images/become_donor/3.png',
              ),
            ),
            Wrap(
              children: [
                myInputField(
                    controller: becomeDonorName,
                    labelText: 'Name',
                    icon: CupertinoIcons.person,
                    onChanged: (value) {}),
                myInputField(
                    controller: becomeDonorEmail,
                    labelText: 'Email',
                    icon: CupertinoIcons.mail,
                    onChanged: (value) {}),
              ],
            ),
            Wrap(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: myText(
                    string: 'Select Blood Group',
                    fontColor: Colors.black54,
                    fontSize: 21,
                    textAlign: TextAlign.start,
                  ),
                ),
                myContainer(
                  height: Screen.deviceHeight * 0.15,
                  containerColor: Colors.green,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      //    mainAxisExtent: Screen.deviceHeight * 0.11,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: bloodDataBecomeDonor.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (bloodDataBecomeDonor[index].click == false) {
                            bloodDataBecomeDonor[index].imgPath = 'select2';
                            bloodDataBecomeDonor[index].click = true;
                            for (int i = 0;
                                i < bloodDataBecomeDonor.length;
                                i++) {
                              if (i != index) {
                                bloodDataBecomeDonor[i].imgPath = '2';
                                bloodDataBecomeDonor[i].click = false;
                              }
                            }
                          } else {
                            bloodDataBecomeDonor[index].imgPath = '2';
                            bloodDataBecomeDonor[index].click = false;
                          }
                        });
                      },
                      child: myBloodCard(
                        imgPath: bloodDataBecomeDonor[index].imgPath,
                        bloodGroup: bloodDataBecomeDonor[index].bloodGroup,
                        bloodGroupInString:
                            bloodDataBecomeDonor[index].bloodGroupInString,
                        selectedBorderColor: (bloodDataBecomeDonor[index].click)
                            ? Colors.blue
                            : Colors.pink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: _visibleContactNoForOthers
                        ? Colors.green
                        : Colors.black54,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _visibleContactNoForOthers =
                            !_visibleContactNoForOthers;
                      },
                    );
                  },
                ),
                mySizedBox(
                  width: Screen.deviceWidth - 80,
                  child: myText(
                    string:
                        'Do you want your contact number visible for others',
                    fontColor: Colors.black54,
                  ),
                )
              ],
            ),
            mySizedBox(
              width: Screen.deviceWidth * 0.7,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
                child: myText(string: 'Submit'),
                onPressed: () {},
              ),
            ),
            myText(
              string: 'Read more About who can give Blood.',
              fontColor: fontColor,
            ),
            mySizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
