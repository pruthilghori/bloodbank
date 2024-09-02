import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  /// Variable
  String? id;
  String? name;
  String? email;
  String? password;
  String? profileUrl;
  String? bg;
  String? phoneNo;
  String? city;
  String? lastDonationDate;
  bool userLocation = false;

  /// Set
  set setId(String val) => this.id = val;

  set setName(String val) => this.name = val;

  set setEmail(String val) => this.email = val;

  set setPassword(String val) => this.password = val;

  set setProfileUrl(String val) => this.profileUrl = val;

  set setBg(String val) => this.bg = val;

  set setPhoneNo(String val) => this.phoneNo = val;

  set setCity(String val) => this.city = val;

  set setLastDonationDate(String val) => this.lastDonationDate = val;

  set setUserLocation(bool val) => this.userLocation = val;

  /// Get
  get getId => this.id;

  get getName => this.name;

  get getEmail => this.email;

  get getPassword => this.password;

  get getProfileUrl => this.profileUrl;

  get getBg => this.bg;

  get getPhoneNo => this.phoneNo;

  get getCity => this.city;

  get getLastDonationDate => this.lastDonationDate;

  get getUserLocation => this.userLocation;

  UserData() {
    FirebaseFirestore.instance
        .collection('Registration')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((e) {
        print('email id : ${FirebaseAuth.instance.currentUser!.email} ');
        if (e['Email']
            .toString()
            .contains(FirebaseAuth.instance.currentUser!.email.toString())) {
          print(
              'user id : ${e.id} \n name : ${e['Name']} \n Email = ${e['Email']} \n profileUrl : ${e['imageUrl']}');

          setId = e.id;
          setName = e['Name'];
          setEmail = e['Email'];
          setPassword = e['Password'];
          // setCity = e['City'];
          setPhoneNo = e['MobileNo'];
          setLastDonationDate = e['LastDonatedDate'];
          setBg = e['BloodGroup'];
          setProfileUrl = e['imageUrl'];
          setUserLocation = e['showLocation'];
        }
      });
    });
  }
}
