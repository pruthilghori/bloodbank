import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:blood_Bank/LocalData/validations.dart';
import 'package:blood_Bank/api/api.dart';
import 'package:blood_Bank/ui/login/login.dart';
import 'package:blood_Bank/ui/widgets/myField.dart';
import 'package:blood_Bank/ui/widgets/mySizedBox.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/appColors.dart';
import 'package:blood_Bank/utils/appFonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class UiRegistration extends StatefulWidget {
  @override
  _UiRegistrationState createState() => _UiRegistrationState();
}

class _UiRegistrationState extends State<UiRegistration> {
  bool _isClicked = true;

  /// Current stepper step
  int currentStep = 0;
  DatabaseReference db = FirebaseDatabase.instance.ref();

  /// Gender
  String male = "Male";
  String female = "Female";
  String gender = "";

  /// blood Group Data
  String? selectedBloodGroup;
  List bloodGroup = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  bool selectedCityIsClicked = false;
  String? selectedCity, selectedArea;
  List<String> areas = [];

  /// age and weight slider
  double _currentSliderAge = 18;
  double _currentSliderWeight = 50;
  String showWeight = '0', showAge = '0';

  /// TextField  controller
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  ///covid info
  String _covidSuffered = "";
  String _covidTest = "";

  /// check Date status
  bool _clickedDob = false;
  bool _clickedLastDonateDate = false;

  ///date Variables
  DateTime? dateOfBirth;
  DateTime? lastDonatedDate;

  String? dateOfBirthString;

  ///Error message String variables
  String errorName = '',
      errorPhoneNo = '',
      errorGender = '',
      errorDOB = '',
      errorEmail = '',
      errorPassword = '',
      errorCity = '',
      errorArea = '',
      errorBloodGroup = '',
      errorWeight = '',
      errorAge = '',
      errorLastDonatedDate = '',
      errorCovidSuffer = '',
      errorCovidTest = '';

  /// DateTime picker for Dob and lastDonatedBlood;
  datePickerDob(context) async {
    dateOfBirth = (await showDatePicker(
      context: context,
      initialDate: (dateOfBirth == null) ? DateTime(2001) : dateOfBirth,
      firstDate: DateTime(1960),
      lastDate: DateTime(2010),
    ))!;
    // dateOfBirthString = DateFormat('dd-MM-yyyy').format(dateOfBirth);
    // print("__________________$dateOfBirthString");
    setState(() {});
  }

  datePickerLastDonateDate(context) async {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = lastDonatedDate ?? currentDate;
    DateTime initialDate = selectedDate.isAfter(DateTime(2022))
        ? currentDate
        : selectedDate.isBefore(DateTime(1990))
            ? DateTime(1990)
            : selectedDate;

    lastDonatedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    );
    setState(() {});
  }

  List<Map<String, dynamic>> allEmailData = [];

  ///Database object

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference _databaseReference =
      FirebaseFirestore.instance.collection('Registration');

  UiRegistrationState() {
    _databaseReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        allEmailData.add({'Email': element['Email']});
      });
    }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    personalData() {
      return Column(
        children: [
          myInputField(
            controller: name,
            labelText: 'Name',
            icon: Icons.person,
            onChanged: (value) {
              setState(() {
                errorName = validName(value);
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
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                errorPhoneNo = validPhoneNo(value);
              });
            },
          ),
          myText(
            string: errorPhoneNo,
            fontSize: errorFont,
            fontColor: errorColor,
          ),
          Row(
            children: [
              Text('Gender:'),
              Radio(
                value: male,
                groupValue: gender,
                onChanged: (val) {
                  setState(() {
                    gender = val as String;
                    errorGender = validGender(gender);
                  });
                },
              ),
              Text(male),
              Radio(
                value: female,
                groupValue: gender,
                onChanged: (val) {
                  setState(() {
                    gender = val as String;
                    errorGender = validGender(gender);
                  });
                },
              ),
              Text(female),
            ],
          ),
          myText(
              string: errorGender, fontSize: errorFont, fontColor: errorColor),
          Row(
            children: [
              myText(string: 'Date of Birth :'),
              mySizedBox(
                width: 10,
              ),
              MaterialButton(
                onPressed: () {
                  _clickedDob = true;
                  datePickerDob(context);
                  errorDOB = '';
                },
                child: myText(
                  string: _clickedDob
                      ? dateOfBirth != null
                          ? DateFormat('dd-MM-yyyy').format(dateOfBirth!)
                          : 'Select Date'
                      : 'Select Date',
                ),
                color: Colors.white,
              ),
            ],
          ),
          myText(string: errorDOB, fontSize: errorFont, fontColor: errorColor),
          myInputField(
            controller: emailId,
            labelText: 'Email-Id',
            icon: Icons.mail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                errorEmail = validEmail(value);
              });
              if (errorEmail == '') {
                allEmailData.forEach(
                  (element) {
                    if (element["Email"].contains(value)) {
                      print('--------------Already registered');
                      errorEmail = "Email is already Registered";
                      setState(() {});
                    }
                  },
                );
              }
            },
          ),
          myText(
              string: errorEmail, fontSize: errorFont, fontColor: errorColor),
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
                setState(() {
                  errorPassword = validPassword(password.text);
                });
              }),
          myText(
            string: errorPassword,
            fontSize: errorFont,
            fontColor: errorColor,
          ),
          Row(
            children: [
              myText(
                  string: 'City : ', fontSize: 16, fontColor: Colors.black54),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('cities')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error : ${snapshot.error}'),
                      );
                    } else {
                      QuerySnapshot<Map<String, dynamic>> querySnapshot =
                          snapshot.data as QuerySnapshot<Map<String, dynamic>>;
                      List<String> temp = [];
                      querySnapshot.docs.forEach((element) {
                        temp.add(element.id);
                      });
                      return Card(
                        elevation: 2,
                        child: DropdownButton(
                          underline: Text(''),
                          isExpanded: true,
                          hint: myText(string: '  Select City'),
                          value: selectedCity,
                          items: temp
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text('   $e'),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                selectedCityIsClicked = true;
                                selectedCity = value as String;
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          myText(
            string: errorCity,
            fontSize: errorFont,
            fontColor: errorColor,
          ),
          Row(
            children: [
              myText(
                  string: 'Area : ', fontSize: 16, fontColor: Colors.black54),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('cities')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error : ${snapshot.error}'),
                      );
                    } else {
                      QuerySnapshot querySnapshot = snapshot.data;
                      areas.clear();
                      querySnapshot.docs.forEach(
                        (element) {
                          var data = element.data() as Map<String, dynamic>?;
                          if (data != null) {
                            var areasData = data['area'] as List<dynamic>?;
                            if (areasData != null) {
                              for (int i = 0; i < areasData.length; i++) {
                                if (selectedCity != null) {
                                  if (element.id.contains(selectedCity!)) {
                                    var areaValue = areasData[i];
                                    if (areaValue != null) {
                                      areas.add(areaValue);
                                    }
                                  }
                                } else {
                                  areas.clear();
                                }
                              }
                            }
                          }

                          // for (int i = 0;
                          //     i < element.data()['area'].length;
                          //     i++) {
                          //   if (selectedCity != null) {
                          //     if (element.id.contains(selectedCity)) {
                          //       areas.add(element.data()['area'][i]);
                          //     }
                          //   } else {
                          //     areas.clear();
                          //   }

                          //   selectedCity != null
                          //       ? element.id.contains(selectedCity)
                          //           ? areas.add(element.data()['area'][i])
                          //           : print('')
                          //       : areas.clear();
                          // }
                        },
                      );
                      return Card(
                        elevation: 2,
                        child: DropdownButton(
                          underline: Text(''),
                          isExpanded: true,
                          hint: myText(string: '   Select Area'),
                          value: selectedArea,
                          items: areas
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text('   $e'),
                                ),
                              )
                              .toList(),
                          onChanged: selectedCityIsClicked
                              ? (value) {
                                  setState(
                                    () {
                                      selectedArea = value as String;
                                    },
                                  );
                                }
                              : (val) {},
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          myText(
            string: errorArea,
            fontSize: errorFont,
            fontColor: errorColor,
          ),
        ],
      );
    }

    physical_Info() {
      return Column(
        children: [
          Row(
            children: [
              Text(
                "Blood Group :",
                style: TextStyle(color: Colors.black),
              ),
              mySizedBox(width: 10),
              Card(
                elevation: 2,
                child: DropdownButton(
                  elevation: 1,
                  underline: Text(''),
                  value: selectedBloodGroup,
                  items: bloodGroup.map((value) {
                    return DropdownMenuItem(
                      child: myText(string: ' $value'),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      errorBloodGroup = validBloodGroup(value as String);
                      selectedBloodGroup = value;
                    });
                  },
                ),
              ),
            ],
          ),
          myText(
              string: errorBloodGroup,
              fontSize: errorFont,
              fontColor: errorColor),
          Align(
            alignment: Alignment.centerRight,
            child: myText(
              string: "$showWeight Kg",
              fontColor: fontColor,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              myText(string: 'Weight : '),
              Expanded(
                child: Slider(
                  value: _currentSliderWeight,
                  divisions: 50,
                  inactiveColor: Colors.grey,
                  activeColor: fontColor,
                  min: 50,
                  max: 140,
                  label: _currentSliderWeight.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      print("-------$_currentSliderWeight");
                      _currentSliderWeight = value;
                      errorWeight = validWeight(value.toString());

                      showWeight = _currentSliderWeight.toInt().toString();
                    });
                  },
                ),
              ),
            ],
          ),
          myText(
              string: errorWeight, fontSize: errorFont, fontColor: errorColor),
          Align(
            alignment: Alignment.centerRight,
            child: myText(
              string: "$showAge Years",
              fontColor: fontColor,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              myText(string: 'Age : '),
              Expanded(
                child: Slider(
                  value: _currentSliderAge,
                  divisions: 50,
                  inactiveColor: Colors.grey,
                  activeColor: fontColor,
                  min: 18,
                  max: 100,
                  label: _currentSliderAge.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      errorAge = validAge(value.toString());
                      _currentSliderAge = value;
                      showAge = _currentSliderAge.toInt().toString();
                    });
                  },
                ),
              ),
            ],
          ),
          myText(string: errorAge, fontSize: errorFont, fontColor: errorColor),
        ],
      );
    }

    health_Data() {
      return Column(
        children: [
          Row(
            children: [
              Text('Last Donated Date :'),
              mySizedBox(
                width: 10,
              ),
              MaterialButton(
                onPressed: () {
                  _clickedLastDonateDate = true;
                  datePickerLastDonateDate(context);
                  errorLastDonatedDate = '';
                },
                child: myText(
                  string: _clickedLastDonateDate
                      ? lastDonatedDate != null
                          ? DateFormat('dd-MM-yyyy').format(lastDonatedDate!)
                          : 'Select Date'
                      : 'Select Date',
                ),
                color: Colors.white,
              ),
            ],
          ),
          myText(
              string: errorLastDonatedDate,
              fontSize: errorFont,
              fontColor: errorColor),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myText(string: 'Do you have suffered from Covid-19'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: 'No',
                          groupValue: _covidSuffered,
                          onChanged: (value) {
                            setState(() {
                              errorCovidSuffer = validRadio(value as String);
                              _covidSuffered = value;
                            });
                          }),
                      myText(string: 'No'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 'Yes',
                          groupValue: _covidSuffered,
                          onChanged: (value) {
                            setState(() {
                              errorCovidSuffer = validRadio(value as String);
                              _covidSuffered = value;
                            });
                          }),
                      myText(string: 'Yes'),
                    ],
                  ),
                ],
              )
            ],
          ),
          myText(
              string: errorCovidSuffer,
              fontSize: errorFont,
              fontColor: errorColor),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myText(string: 'Have you ever tested for COVID ?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: 'No',
                          groupValue: _covidTest,
                          onChanged: (value) {
                            setState(() {
                              errorCovidTest = validRadio(value as String);
                              _covidTest = value;
                            });
                          }),
                      myText(string: 'No'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 'Yes',
                          groupValue: _covidTest,
                          onChanged: (value) {
                            setState(() {
                              errorCovidTest = validRadio(value as String);
                              _covidTest = value;
                            });
                          }),
                      myText(string: 'Yes'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          myText(
              string: errorCovidTest,
              fontSize: errorFont,
              fontColor: errorColor),
        ],
      );
    }

    List<Step> steps = [
      Step(
        title: myText(string: 'Personal Details'),
        content: personalData(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: myText(string: 'Physical Info'),
        content: physical_Info(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: myText(string: 'Covid Info'),
        content: health_Data(),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Group3.png',
                  height: 50,
                  width: 50,
                ),
                mySizedBox(height: 10),
                myText(
                  string: 'Sign Up',
                  fontSize: 33,
                  fontColor: fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Expanded(
              child: Stepper(
                currentStep: this.currentStep,
                steps: steps,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                onStepContinue: () async {
                  setState(() {
                    if (currentStep <= steps.length - 1) {
                      if (currentStep == 0) {
                        errorName = validName(name.text);
                        errorPhoneNo = validPhoneNo(mobileNo.text);
                        errorGender = validGender(gender);
                        if (_clickedDob) {
                          errorDOB = '';
                        } else {
                          errorDOB = 'Please Select Date';
                        }
                        errorEmail = validEmail(emailId.text);

                        if (errorEmail == '') {
                          allEmailData.forEach(
                            (element) {
                              if (element["Email"].contains(emailId.text)) {
                                errorEmail = "Email is already Registered";
                              }
                            },
                          );
                        }

                        errorPassword = validPassword(password.text);

                        if (selectedCity == null) {
                          errorCity = 'Please Select City';
                        } else {
                          errorCity = '';
                        }
                        if (selectedArea == null) {
                          errorArea = 'Please Select Area';
                        } else {
                          errorArea = '';
                        }

                        print(
                            'error messages name $errorName \n phone no $errorPhoneNo  \ngender $errorGender \n '
                            'DOB $errorDOB \n email $errorEmail \n password $errorPassword \n city $errorCity \n area $errorArea  ');

                        if (errorName == '' &&
                            errorPhoneNo == '' &&
                            errorGender == '' &&
                            errorDOB == '' &&
                            errorEmail == '' &&
                            errorPassword == '' &&
                            errorCity == '' &&
                            errorArea == '') {
                          currentStep = currentStep + 1;
                        }
                      } else if (currentStep == 1) {
                        if (selectedBloodGroup != null) {
                          errorBloodGroup =
                              validBloodGroup(selectedBloodGroup!);
                        } else {
                          print("selectedBloodGroup is null");
                          errorBloodGroup = "Please select a blood group";
                        }

                        errorWeight =
                            validWeight(_currentSliderWeight.toString());
                        errorAge = validAge(_currentSliderAge.toString());

                        if (errorBloodGroup == '' &&
                            errorWeight == '' &&
                            errorAge == '') {
                          currentStep = currentStep + 1;
                        }
                      } else if (currentStep == 2) {
                        if (_clickedLastDonateDate) {
                          errorLastDonatedDate = '';
                        } else {
                          errorLastDonatedDate = 'Please Select Date';
                        }
                        errorCovidSuffer = validRadio(_covidSuffered);
                        errorCovidTest = validRadio(_covidTest);
                        if (errorLastDonatedDate == '' &&
                            errorCovidSuffer == '' &&
                            errorCovidTest == '') {
                          print('-----------------covid Info Done');

                          //Insert Data in Database(firebase)
                          try {
                            firebaseAuth.createUserWithEmailAndPassword(
                                email: emailId.text, password: password.text);
                          } catch (signUpError) {
                            if (signUpError is FirebaseAuthException) {
                              if (signUpError.code ==
                                  'ERROR_EMAIL_ALREADY_IN_USE') {
                                errorEmail = 'Email is Already Register';
                              } else {
                                print("Error:${signUpError.message}");
                              }
                            }
                          }

                          // firebaseAuth.createUserWithEmailAndPassword(
                          //   email: emailId.text,
                          //   password: password.text,
                          // );
                          String? pushKey = db.push().key;

                          db.child('Registration').child(pushKey!).set(
                            {
                              'Name': name.text,
                              'MobileNo': mobileNo.text,
                              'City': selectedCity,
                              'Gender': gender,
                              'DOB':
                                  DateFormat('dd-MM-yyyy').format(dateOfBirth!),
                              'Email': emailId.text,
                              'Password': password.text,
                              'BloodGroup': selectedBloodGroup,
                              'Weight': showWeight,
                              'Age': showAge,
                              'LastDonatedDate': (lastDonatedDate == null)
                                  ? 'No'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(lastDonatedDate!),
                              'CovidSuffered': _covidSuffered,
                              'CovidTest': _covidTest,
                            },
                          );
                          firebaseAuth.createUserWithEmailAndPassword(
                            email: emailId.text,
                            password: password.text,
                          );
                          FirebaseMessaging _firebaseMessaging =
                              FirebaseMessaging.instance;
                          FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            CollectionReference reference = FirebaseFirestore
                                .instance
                                .collection("Registration");
                            String? pushToken =
                                await _firebaseMessaging.getToken();
                            print("push Token:$pushToken");
                            await reference.add({
                              'Name': name.text,
                              'MobileNo': mobileNo.text,
                              'City': selectedCity,
                              'Area': selectedArea,
                              'Gender': gender,
                              'DOB':
                                  DateFormat('dd-MM-yyyy').format(dateOfBirth!),
                              'Email': emailId.text,
                              'Password': password.text,
                              'BloodGroup': selectedBloodGroup,
                              'Weight': showWeight,
                              'Age': showAge,
                              'LastDonatedDate': (lastDonatedDate == null)
                                  ? 'No'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(lastDonatedDate!),
                              'CovidSuffered': _covidSuffered,
                              'CovidTest': _covidTest,
                              'imageUrl':
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                              'registerAt': DateFormat('dd-MM-yyyy-kk:mm')
                                  .format(DateTime.now()),
                              'showLocation': false,
                              'pushToken': pushToken
                            }).whenComplete(() => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => UiLoginScreen(),
                                  ),
                                ));
                          });
                        }
                      } else {
                        currentStep = 0;
                      }
                    }
                  });
                },
                onStepCancel: () {
                  setState(
                    () {
                      if (currentStep > 0) {
                        currentStep = currentStep - 1;
                      } else {
                        currentStep = 0;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
