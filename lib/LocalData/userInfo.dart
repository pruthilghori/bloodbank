import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

setUserInfo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  FirebaseFirestore.instance
      .collection('Registration')
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((element) {
      if (element["Email"] == FirebaseAuth.instance.currentUser!.email) {
        // userId = element.id;
        // currentUser = element["Name"];
        // userBlood = element["BloodGroup"];
        // userEmail = element["Email"];
        // url = element["imageUrl"];
        // phoneNo = element["MobileNo"];
        // userCity = element["City"];
        // userPassword = element["MobileNo"];
        // userShowLocation = element['showLocation'];
        // if (element["LastDonatedDate"] != null) {
        //   lastDonationDate = element["LastDonatedDate"];
        // } else {
        //   lastDonationDate = "No";
        // }
        pref.setString('Id', element.id);
        pref.setString('Name', element['Name']);
        pref.setString('BG', element['BloodGroup']);
        pref.setString('Email', element['Email']);
        pref.setString('Password', element['Password']);
        pref.setString('ProfileUrl', element['imageUrl']);
        pref.setString('PhoneNo', element['MobileNo']);
        pref.setString('City', element['City'].toString());
        pref.setString('Area', element['Area'].toString());
        pref.setString(
          'LastDonatedDate',
          element['LastDonatedDate'] != null
              ? element['LastDonatedDate'].toString()
              : 'No',
        );
        pref.setString('DOB', element['DOB']);
      }
    });
  }).whenComplete(() {
    pref.setString('Login', 'done');
    print('login done  ${pref.getString('Login')}');
  });

  // print('set user login call');
  // FirebaseFirestore.instance
  //     .collection('Registration')
  //     .snapshots()
  //     .forEach((querySnapshot) {
  //   querySnapshot.docs.forEach((element) {
  //     if (element["Email"] == FirebaseAuth.instance.currentUser.email) {
  //       pref.setString('Id', element.id);
  //       pref.setString('Name', element['Name']);
  //       pref.setString('BG', element['BloodGroup']);
  //       pref.setString('Email', element['Email']);
  //       pref.setString('Password', element['Password']);
  //       pref.setString('ProfileUrl', element['imageUrl']);
  //       pref.setString('PhoneNo', element['MobileNo']);
  //       pref.setString('City', element['City'].toString() ?? 'area');
  //       pref.setString('Area', element['Area'].toString() ?? 'Area');
  //       pref.setString(
  //         'LastDonatedDate',
  //         element['LastDonatedDate'] != null
  //             ? element['LastDonatedDate'].toString()
  //             : 'No',
  //       );
  //       pref.setString('DOB', element['DOB']);
  //     }
  //   });
  // }).whenComplete(() {
  //   pref.setString('Login', 'done');
  //   print('login done  ${pref.getString('Login')}');
  // });
}
