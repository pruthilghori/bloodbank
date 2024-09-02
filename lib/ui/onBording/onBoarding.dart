import 'package:blood_Bank/model/sliderData.dart';
import 'package:blood_Bank/ui/login/Login.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiOnBoarding extends StatefulWidget {
  @override
  _UiOnBoardingState createState() => _UiOnBoardingState();
}

class _UiOnBoardingState extends State<UiOnBoarding> {
  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  Widget pageIndexIndicator(bool isCurrentPage, int i) {
    return GestureDetector(
      onTap: () {
        _pageController.jumpToPage(i);
      },
      child: Icon(
        Icons.circle,
        size: isCurrentPage ? 15 : 12,
        color: isCurrentPage ? Colors.pink[400] : Colors.grey[400],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.black54,
      //     ),
      //     onPressed: () {},
      //   ),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(right: 15),
      //       child: Icon(Icons.menu, color: Colors.black),
      //     ),
      //   ],
      // ),
      // appBar: myAppbar(
      //   // title: myText(string: 'title', fontColor: Colors.black),
      //   leading: Icon(
      //     Icons.arrow_back,
      //     color: appbarIconColor,
      //   ),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(right: 15),
      //       child: Icon(
      //         Icons.menu,
      //         color: appbarIconColor,
      //       ),
      //     ),
      //   ],
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // color: Colors.green,
            height: Screen.deviceHeight * 0.6,
            child: PageView.builder(
              controller: _pageController,
              itemCount: getSlider.length,
              onPageChanged: (val) {
                setState(() {
                  _currentIndex = val;
                });
              },
              itemBuilder: (context, index) => Container(
                width: Screen.deviceWidth,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: Screen.deviceHeight * 0.120,
                      child: Container(
                        width: Screen.deviceWidth,
                        child: Image.asset(
                          getSlider[index].assetImgPath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          myText(string: getSlider[index].title, fontSize: 25),
                          myText(
                            string: getSlider[index].desc,
                            // textAlign: TextAlign.center
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),
          SizedBox(
            width: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < getSlider.length; i++)
                  _currentIndex == i
                      ? pageIndexIndicator(true, i)
                      : pageIndexIndicator(false, i)
              ],
            ),
          ),

          CupertinoButton(
            color: Colors.pink[400],
            child: Text('Let\'s Begin'),
            onPressed: _currentIndex == 2
                ? () {
                    // setletBegin();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UiLoginScreen(),
                      ),
                    );
                  }
                : () {
                    print("sorry you can not go next page");
                  },
          ),

          GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                getSlider.length - 1,
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
            child: myText(
              string: 'Skip step',
            ),
          ),
        ],
      ),
    );
  }
}
