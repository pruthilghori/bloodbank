import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:flutter/material.dart';

Widget myColumnCard({icon, required String text, required String textDetails}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(
        icon,
        size: 50,
        color: Colors.pink[300],
      ),
      myText(
        string: text,
        fontSize: 20,
        fontColor: Colors.pink,
      ),
      myText(string: textDetails),
    ],
  );
}
