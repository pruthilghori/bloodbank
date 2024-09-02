import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/material.dart';

myBloodCard({
  required String imgPath,
  required String bloodGroup,
  required String bloodGroupInString,
  required Color selectedBorderColor,
}) {
  return myContainer(
    containerBorderRadius: BorderRadius.circular(15),
    containerBorder:
        Border.all(color: selectedBorderColor ?? Colors.pink[300]!),
    child: Column(
      children: [
        Container(
          height: Screen.deviceHeight * 0.1,
          width: Screen.deviceWidth * 0.17,
          padding: EdgeInsets.all(2),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/select_blood_group/$imgPath.png',
              ),
              Positioned(
                right: 0,
                top: 5,
                child: CircleAvatar(
                  backgroundColor: Color(0xff464a57),
                  child: myText(string: bloodGroup, fontColor: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
