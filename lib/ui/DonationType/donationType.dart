import 'package:blood_Bank/ui/DonationType/ModelCalss.dart';
import 'package:blood_Bank/ui/widgets/myAppBar.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiDonationType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: [
          Container(
            height: Screen.deviceHeight * 0.39,
            decoration: BoxDecoration(
              color: Colors.pink[300],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                myAppbar(),
                Positioned(
                  bottom: 0,
                  height: Screen.deviceHeight * 0.28,
                  child: Image.asset(
                    'assets/images/donationtype/2.png',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: donationTypeData.length,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              physics: (Screen.deviceHeight <= 600)
                  ? null
                  : NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                // mainAxisExtent: Screen.deviceHeight * 0.20,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  print(donationTypeData[index].text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            donationTypeData[index].navigatorClass,
                      ));
                },
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.pink[200],
                      ),
                      myText(
                        string: donationTypeData[index].text,
                        fontSize: 18,
                        fontColor: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                      myText(
                        string: donationTypeData[index].textDetail,
                        fontColor: Colors.black54,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: Screen.deviceWidth - 150,
            child: CupertinoButton(
              color: Colors.blue,
              child: myText(string: 'Next'),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ), //body column
    );
  }
}
