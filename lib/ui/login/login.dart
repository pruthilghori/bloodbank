import 'package:blood_Bank/LocalData/loginData.dart';
import 'package:blood_Bank/LocalData/validations.dart';
import 'package:blood_Bank/ui/DashBoard/home.dart';
import 'package:blood_Bank/ui/Registration/registration.dart';
import 'package:blood_Bank/ui/login/forgetPassword.dart';
import 'package:blood_Bank/ui/widgets/myField.dart';
import 'package:blood_Bank/ui/widgets/mySizedBox.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:blood_Bank/utils/appColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiLoginScreen extends StatefulWidget {
  @override
  _UiLoginScreenState createState() => _UiLoginScreenState();
}

class _UiLoginScreenState extends State<UiLoginScreen> {
  ///firebase
  DatabaseReference db = FirebaseDatabase.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var dataMap;

  ///key for login screen scaffold
  final GlobalKey<ScaffoldState> uiLoginScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  ///validation Variables
  String errorUserName = '', errorPassword = '', errorUserNotFound = '';
  bool _isClicked = true;
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  var _alignment;

  @override
  initState() {
    _alignment = Alignment.topCenter;
    super.initState();
  }

  String? testUser;

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);
    _alignment = Alignment.bottomCenter;
    return Scaffold(
      key: uiLoginScreenScaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Container(
              height: Screen.deviceHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AnimatedContainer(
                        height: 150,
                        // color: Colors.green,
                        duration: Duration(seconds: 2),
                        alignment: _alignment,
                        child: Image.asset(
                          'assets/images/Group3.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      mySizedBox(height: 20),
                      myText(
                        string: 'Sign In',
                        fontSize: 35,
                        fontColor: fontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Wrap(
                    // alignment: WrapAlignment.center,
                    runSpacing: 5,
                    children: [
                      myInputField(
                        controller: username,
                        icon: Icons.mail_outline,
                        labelText: 'Email',
                        onChanged: (str) {
                          setState(() {
                            errorUserNotFound = '';
                            errorUserName = validEmail(username.text);
                          });
                        },
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: Screen.deviceWidth * 0.15),
                        child: myText(
                          string: errorUserName,
                          fontColor: errorColor,
                        ),
                      ),
                      myInputField(
                        controller: password,
                        labelText: 'Password',
                        icon: Icons.lock,
                        obscureText: _isClicked,
                        suffix: IconButton(
                            icon: Icon(
                              _isClicked
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: fontColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isClicked = !_isClicked;
                              });
                            }),
                        onChanged: (str) {
                          setState(() {
                            errorUserNotFound = '';
                            errorPassword = validPassword(password.text);
                          });
                        },
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: Screen.deviceWidth * 0.15),
                        child: myText(
                          string: errorPassword,
                          fontColor: errorColor,
                        ),
                      ),
                      Builder(
                        builder: (BuildContext context) => Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                elevation: 1,
                                context: context,
                                builder: (_) {
                                  return ForgetPassword();
                                },
                              );
                            },
                            child: myText(
                              string: 'Forgot Password ? ',
                              fontColor: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  myText(string: errorUserNotFound, fontColor: errorColor),
                  CupertinoButton(
                    borderRadius: BorderRadius.circular(12),
                    color: buttonColor,
                    child: myText(string: 'Sign In'),
                    onPressed: () async {
                      errorUserName = validEmail(username.text);
                      errorPassword = validPassword(password.text);

                      if (errorUserName == '' && errorPassword == '') {
                        // ignore: deprecated_member_use
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 3),
                            content: Row(
                              children: [
                                CircularProgressIndicator(
                                  backgroundColor: Colors.pink[300],
                                ),
                                SizedBox(width: 10),
                                Text('Signing-In...')
                              ],
                            ),
                          ),
                        );
                        try {
                          await firebaseAuth.signInWithEmailAndPassword(
                              email: username.text, password: password.text);
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UiHome(),
                                ));
                          });
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          print('set data start');
                          FirebaseFirestore.instance
                              .collection('Registration')
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs.forEach((element) {
                              if (element["Email"] == username.text) {
                                pref.setString('Email', element["Email"]);
                              }
                            });
                          });
                          setletBeginLogin();
                        } catch (error) {
                          print('Error during sign-in: $error');
                          if (error is FirebaseAuthException) {
                            if (error.code == 'wrong-password' ||
                                error.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Invalid email or password. Please try again.')));
                            }
                          }
                        }

                        // print('error in login $error');

                        // pref.setBool("isUserLogin", true);
                      }
                    },
                  ),
                  Wrap(
                    children: [
                      myText(string: 'Do you have an'),
                      //you can you gestureDetector hear also
                      InkWell(
                        onTap: () {
                          print("Account click");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UiRegistration(),
                            ),
                          );
                        },
                        child: myText(
                          string: ' Account ?',
                          fontColor: fontColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Data {
  static String? data;

  static test([recieve]) {
    data = recieve;
    print(data);
  }
}
