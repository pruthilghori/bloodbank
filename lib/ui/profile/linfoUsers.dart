import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info {
  static String userId = '';
  static String currentUser = '';
  static String userBlood = '';
  static String userEmail = '';
  static String url = '';
  static String phoneNo = '';
  static String userCity = '';
  static String lastDonationDate = '';
  static String userPassword = '';
  static bool userShowLocation = false;
  static String userArea = '';
  static String userDateOfBirth = '';
  static String userStatus = '';

  static set setUserId(String id) {
    userId = id;
  }

  static Future<void> getUser() async {
    await FirebaseFirestore.instance
        .collection('Registration')
        .snapshots()
        .forEach((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? email = pref.getString('Email');
        if (element["Email"] == email) {
          userId = element.id;
          //  setUserId = element.id;
          currentUser = element["Name"];
          userBlood = element["BloodGroup"];
          userEmail = element["Email"];
          url = element["imageUrl"];
          print("url=========================$url");
          //  phoneNo = element["MobileNo"];
          userCity = element["City"];
          userPassword = element["MobileNo"];
          // userStatus = element["status"];
          userShowLocation = element['showLocation'];
          userArea = element['Area'];
          userDateOfBirth = element['DOB'];
          Map<String, dynamic> elementdata =
              element.data() as Map<String, dynamic>;
          if (elementdata.containsKey("MobileNo")) {
            phoneNo = element["MobileNo"];
          } else {
            phoneNo = "No Phone Number"; // Provide a default value
          }

          if (elementdata.containsKey("status")) {
            userStatus = element["status"];
          } else {
            userStatus =
                "No Status"; // Provide a default value if the field is not present
          }
          if (element["LastDonatedDate"] != null) {
            lastDonationDate = element["LastDonatedDate"];
          } else {
            lastDonationDate = "No";
          }
          pref.setString("ProfileUrl", url);
          pref.setString("Name", currentUser);
          pref.setString("Email", userEmail);
        }
      });
    }).whenComplete(() {});
  }
}

class GetImage {
  static String? urlOfImage;

  static Future<void> getUrl() async {
    try {
      String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Images")
          .where("email", isEqualTo: userEmail)
          .get();
      if (querySnapshot.docs.isEmpty) {
        urlOfImage = querySnapshot.docs.first["url"];
      } else {
        urlOfImage = null;
      }
    } catch (error) {
      print("Error fetching image URL: $error");
      urlOfImage = null;
    }
    // FirebaseFirestore.instance
    //     .collection("Images")
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((element) {
    //     if (element["email"] == FirebaseAuth.instance.currentUser!.email) {
    //       urlOfImage = element["url"];
    //     }
    //   });
    // });
  }
}
