import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  List<User> listUser = [];
  User? user;
  final firebaseReference = FirebaseDatabase.instance;
  final db = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;

  void _onAddData(DataSnapshot snapshot) {
    setState(() {
      listUser.add(User.forSnapshot(snapshot));
    });
  }

  // void _onChanged(Event event) {
  //   var oldData= listUser.singleWhere((entry){
  //     return entry.key==event.snapshot.key;
  //   });
  //   setState(() {
  //     listUser[listUser.indexOf(oldData)]=User.forSnapshot(event.snapshot);
  //   });
  // }

  void handlePostData() {
    databaseReference!.push().set(user!.toJson());
  }

  List listData = [];

  @override
  void initState() {
    super.initState();
    user = User();
    databaseReference = firebaseReference.ref().child("Registration");
    // firebaseReference
    //     .child("Registration")
    //     .once()
    //     .then((value) => print("***  ${value.value}"));
    databaseReference!.onChildAdded.listen((event) {
      _onAddData(event.snapshot);
    });
    // databaseReference.onChildChanged.listen((_onChanged));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class User {
  String? name;
  String? bloodGroup;
  String? city;
  String? userEmail;
  // String city;
  String? key;

  User({this.name, this.bloodGroup, this.city, this.userEmail, this.key});

  User.forSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = (snapshot.value as Map<String, dynamic>)["Name"],
        bloodGroup = (snapshot.value as Map<String, dynamic>)["BloodGroup"],
        city = (snapshot.value as Map<String, dynamic>)["City"],
        userEmail = (snapshot.value as Map<String, dynamic>)["Email"];

  //  city = snapshot.value["City"];

  toJson() {
    return {
      "Name": name,
      "BloodGroup": bloodGroup,
      "City": city,
      "Email": userEmail,
      // "City":city,
    };
  }
}
