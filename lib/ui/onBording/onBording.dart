import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBording extends StatefulWidget {
  @override
  _OnBordingState createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                // InkWell(
                //   child: Image.asset(
                //     'assets/images/menu_left_alt.png',
                //     // width: 50,
                //   ),
                // ),
                IconButton(
                  icon: Icon(
                    Icons.segment,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Image.asset('assets/images/onBording/vector1_4.png'),
            // Container(
            //   height: 600,
            //   child: SKOnboardingScreen(
            //     bgColor: Colors.white,
            //     pages: pages,
            //     getStartedClicked: (String value) {},
            //     themeColor: Colors.lightGreen,
            //     skipClicked: (String value) {},
            //   ),
            // ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Wrap(
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      myText(
                        string: 'Find Donators',
                        fontSize: 25,
                        fontColor: Colors.black87,
                      ),
                      myText(
                        string:
                            'Dramatically unleash cutting-edge vortals before maintainable platforms.',
                        textAlign: TextAlign.center,
                        fontColor: Colors.black45,
                      ),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      CupertinoButton(
                        color: Colors.red[200],
                        child: myText(
                          string: 'Let\'s Begin',
                          fontColor: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      InkWell(
                        child: myText(
                          string: 'Skip step',
                          fontColor: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
