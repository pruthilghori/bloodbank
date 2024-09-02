import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/material.dart';

Widget myCardContainer({
  required Color circleAvatarBgColor,
  required IconData circleAvatarIcon,
  required Color circleAvatarIconColor,
  required String typeString,
  required String typeValueString,
}) =>
    myContainer(
      containerBorderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      height: Screen.deviceHeight * 0.22,
      width: Screen.deviceWidth * 0.4,
      containerColor: Colors.pink[50],
      containerBoxShadow: [
        BoxShadow(color: Colors.white, blurRadius: 10, offset: Offset(0, 0))
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: circleAvatarBgColor,
            radius: 30,
            child: Icon(
              circleAvatarIcon,
              color: circleAvatarIconColor,
            ),
          ),
          myText(string: typeString),
        ],
      ),
    );
