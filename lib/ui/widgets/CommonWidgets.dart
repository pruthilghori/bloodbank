import 'package:flutter/material.dart';

Widget mybtn() => ElevatedButton(
      onPressed: () {},
      child: Text("Raised btn"),
    );

//do not use
Widget mybtn1() => ElevatedButton(onPressed: () {}, child: Text("Flatbtn"));
