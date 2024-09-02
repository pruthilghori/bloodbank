import 'package:blood_Bank/LocalData/validations.dart';
import 'package:blood_Bank/ui/widgets/myField.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:blood_Bank/utils/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController forgetPasswordEmail = TextEditingController();
  String errorForgetEmail = '', snackBarMessage = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 280,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myText(
                string: 'Forget Password',
                fontSize: 22,
                fontColor: Colors.black54,
              ),
              Column(
                children: [
                  myInputField(
                    controller: forgetPasswordEmail,
                    labelText: 'Email',
                    icon: Icons.email_outlined,
                    onChanged: (value) {
                      setState(() {
                        snackBarMessage = '';
                        errorForgetEmail = validEmail(value);
                      });
                    },
                  ),
                  myText(
                    string: errorForgetEmail == ''
                        ? snackBarMessage
                        : errorForgetEmail,
                    fontColor: errorColor,
                  ),
                ],
              ),
              SizedBox(
                width: Screen.deviceWidth - 150,
                child: CupertinoButton(
                  color: buttonColor,
                  onPressed: () {
                    errorForgetEmail = validEmail(forgetPasswordEmail.text);
                    if (errorForgetEmail == '') {
                      firebaseAuth
                          .sendPasswordResetEmail(
                              email: forgetPasswordEmail.text)
                          .catchError((error) {
                        print('#Error in forget password# -- ${error.code}');

                        if (error.code == 'user-not-found') {
                          setState(() {
                            snackBarMessage = 'User Does not exist';
                          });
                        }
                      }).whenComplete(() {
                        if (snackBarMessage == '') {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: myText(
                                  string:
                                      'Email has been send to \' ${forgetPasswordEmail.text} \' ',
                                  fontColor: Colors.white),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          forgetPasswordEmail.clear();
                        }
                      });
                    }
                  },
                  child: myText(
                    string: "Submit",
                    fontColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
