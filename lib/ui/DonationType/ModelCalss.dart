import 'package:blood_Bank/ui/BloodBank/finalBloodBank.dart';
import 'package:flutter/material.dart';

import '../DashBoard/dashBoard.dart';
import '../becomeDonor/becomeDonor.dart';
import '../profile/profile.dart';

class DonationType {
  String text, textDetail;
  Widget navigatorClass;
  DonationType(
      {required this.text,
      required this.textDetail,
      required this.navigatorClass});
}

List<DonationType> donationTypeData = [
  DonationType(
    text: 'Blood',
    textDetail: 'do you want to visible your contact to other',
    navigatorClass: UiProfile(),
  ),
  DonationType(
    text: 'Powder Red',
    textDetail: 'do you want to visible your contact to other',
    navigatorClass: UiBecomeDonor(),
  ),
  DonationType(
    text: 'Platelets',
    textDetail: 'do you want to visible your contact to other',
    navigatorClass: UiDashBoard(),
  ),
  DonationType(
    text: 'AB Plasma',
    textDetail: 'do you want to visible your contact to other',
    navigatorClass: UiBloodBank(),
  ),
];
