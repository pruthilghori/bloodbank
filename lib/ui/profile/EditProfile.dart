import 'package:blood_Bank/LocalData/validations.dart';
import 'package:blood_Bank/ui/widgets/myField.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/appColors.dart';
import 'package:blood_Bank/utils/appFonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:blood_Bank/ui/profile/linfoUsers.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController(text: Info.currentUser);
  TextEditingController mobileNo = TextEditingController(text: Info.phoneNo);
  TextEditingController emailId = TextEditingController(text: Info.userEmail);
  TextEditingController password =
      TextEditingController(text: Info.userPassword);
  bool _isClicked = true;
  String errorName = '';
  String errorPhoneNo = '';
  String errorEmail = '';
  String errorPassword = '';
  DatabaseReference _EditDatabase =
      FirebaseDatabase.instance.ref().child('Registration');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.pink[400],
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Screen.deviceHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                myInputField(
                  controller: name,
                  labelText: 'Name',
                  icon: Icons.person,
                  onChanged: (value) {
                    setState(() {
                      errorName = validName(name.text);
                    });
                    FirebaseFirestore.instance
                        .collection("Registration")
                        .get()
                        .then((QuerySnapshot querysnapshot) {
                      querysnapshot.docs.forEach((element) {
                        if (element["Email"] ==
                            FirebaseAuth.instance.currentUser!.email) {
                          FirebaseFirestore.instance
                              .collection("Registration")
                              .doc(element.id)
                              .update({
                            'Name': name.text,
                          }).then((value) {
                            print("jghjhg");
                          });
                        }
                      });
                    });
                  },
                ),
                myText(
                  string: errorName,
                  fontSize: errorFont,
                  fontColor: errorColor,
                ),
                myInputField(
                  controller: mobileNo,
                  labelText: 'Mobile No',
                  icon: Icons.phone_in_talk,
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection("Registration")
                        .get()
                        .then((QuerySnapshot querysnapshot) {
                      querysnapshot.docs.forEach((element) {
                        if (element["Email"] ==
                            FirebaseAuth.instance.currentUser!.email) {
                          if (mobileNo.text != null) {
                            FirebaseFirestore.instance
                                .collection("Registration")
                                .doc(element.id)
                                .update({
                              'MobileNo': mobileNo.text,
                            }).then((value) {
                              print("jghjhg");
                            });
                          }
                        }
                      });
                    });
                    setState(() {
                      errorPhoneNo = validPhoneNo(mobileNo.text);
                    });
                  },
                ),
                myText(
                  string: errorPhoneNo,
                  fontSize: errorFont,
                  fontColor: errorColor,
                ),
                myInputField(
                  controller: emailId,
                  labelText: 'Email-Id',
                  icon: Icons.mail,
                  // onFieldSubmitted: (value) {
                  //   setState(() {});
                  //   print('---------------------------$value Email field submited');
                  //   //hear check email is already exits in database or not
                  // },
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection("Registration")
                        .get()
                        .then((QuerySnapshot querysnapshot) {
                      querysnapshot.docs.forEach((element) {
                        if (element["Email"] ==
                            FirebaseAuth.instance.currentUser!.email) {
                          if (emailId.text != null) {
                            FirebaseFirestore.instance
                                .collection("Registration")
                                .doc(element.id)
                                .update({
                              'Email': emailId.text,
                            }).then((value) {
                              print("jghjhg");
                            });
                          }
                        }
                      });
                    });
                    setState(() {
                      // allEmailData.forEach(
                      //   (element) {
                      //     if (element["Email"].contains(value)) {
                      //       print('--------------Already registered');
                      //       errorEmail = "Email is already Registered";
                      //     }
                      //   },
                      // );
                      errorEmail = validEmail(emailId.text);
                    });
                  },
                ),
                myText(
                    string: errorEmail,
                    fontSize: errorFont,
                    fontColor: errorColor),
                myInputField(
                  controller: password,
                  labelText: 'Password',
                  icon: Icons.lock,
                  obscureText: _isClicked,
                  suffix: IconButton(
                      icon: Icon(
                        _isClicked ? Icons.visibility_off : Icons.visibility,
                        color: fontColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isClicked = !_isClicked;
                        });
                      }),
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection("Registration")
                        .get()
                        .then((QuerySnapshot querysnapshot) {
                      querysnapshot.docs.forEach((element) {
                        if (element["Email"] ==
                            FirebaseAuth.instance.currentUser!.email) {
                          if (password.text != null) {
                            FirebaseFirestore.instance
                                .collection("Registration")
                                .doc(element.id)
                                .update({
                              'Password': password.text,
                            }).then((value) {
                              print("jghjhg");
                            });
                          }
                        }
                      });
                    });
                    setState(() {
                      errorPassword = validPassword(password.text);
                    });
                  },
                ),
                myText(
                    string: errorPassword,
                    fontSize: errorFont,
                    fontColor: errorColor),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: CupertinoButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.pink[400],
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text("Profile Updated..."),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
