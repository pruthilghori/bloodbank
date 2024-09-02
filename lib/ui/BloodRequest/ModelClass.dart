import 'package:flutter/material.dart';

class IsClicked {
  String imgPath;
  bool click;
  String bloodGroup;
  String bloodGroupInString;
  IsClicked(
      {required this.imgPath,
      required this.click,
      required this.bloodGroup,
      required this.bloodGroupInString});
}

List<IsClicked> bloodData = [
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'A+',
    bloodGroupInString: 'A Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'A-',
    bloodGroupInString: 'A Negative',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'B+',
    bloodGroupInString: 'B Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'B-',
    bloodGroupInString: 'B Negative',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'AB+',
    bloodGroupInString: 'AB Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'AB-',
    bloodGroupInString: 'AB Negative',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'O+',
    bloodGroupInString: 'O Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'O-',
    bloodGroupInString: 'O Negative',
  ),
];

List<IsClicked> bloodDataBecomeDonor = [
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'A+',
    bloodGroupInString: 'A Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'A-',
    bloodGroupInString: 'A Negative',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'B+',
    bloodGroupInString: 'B Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'B-',
    bloodGroupInString: 'B Negative',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'AB+',
    bloodGroupInString: 'AB Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'AB-',
    bloodGroupInString: 'AB Negative',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'O+',
    bloodGroupInString: 'O Positive',
  ),
  IsClicked(
    imgPath: '2',
    click: false,
    bloodGroup: 'O-',
    bloodGroupInString: 'O Negative',
  ),
];

class DataModel {
  String? img;
  String? txt;
  String? pic;
  String? t;
  String? ptxt;
  String? Pimg;
  String? atext;
  IconData? dicon;
  String? dtxt;
  String? lt;
  String? ltext;
  Widget? page;

  DataModel({
    this.img,
    this.t,
    this.atext,
    this.dicon,
    this.dtxt,
    this.lt,
    this.ltext,
    this.pic,
    this.Pimg,
    this.ptxt,
    this.txt,
    this.page,
  });
}
