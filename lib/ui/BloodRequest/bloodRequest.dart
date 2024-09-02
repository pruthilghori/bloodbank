import 'package:blood_Bank/ui/BloodRequest/myBloodCard.dart';
import 'package:blood_Bank/ui/BloodRequest/sendRequest.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ModelClass.dart';

class UiBloodRequest extends StatefulWidget {
  @override
  _UiBloodRequestState createState() => _UiBloodRequestState();
}

class _UiBloodRequestState extends State<UiBloodRequest> {
  List<String> city = [
    "Surat",
    "Baroda",
    "Ahmedabad",
    "Vapi",
    "Rajkot",
  ];
  List<String> unitOfBlood = [
    '1 Unit',
    '2 Unit',
    '3 Unit',
    '4 Unit',
    '5 Unit',
    '6 Unit'
  ];
  String? selectedUnit;
  String? blood;
  String? selectedCity;
  final CollectionReference _referenceBloodRequest =
      FirebaseFirestore.instance.collection('blood_request');

  getCity() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: DropdownButton(
        underline: Text(''),
        elevation: 3,
        value: selectedCity,
        items: city.map((value) {
          return DropdownMenuItem(
            child: myText(string: '  $value'),
            value: value,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCity = value.toString();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Blood Request",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 10),
          Container(
            width: Screen.deviceWidth,
            height: Screen.deviceHeight * 0.30,
            //color: Colors.green,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: bloodData.length,
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (bloodData[index].click == false) {
                      bloodData[index].imgPath = 'select2';
                      bloodData[index].click = true;
                      for (int i = 0; i < bloodData.length; i++) {
                        if (i != index) {
                          bloodData[i].imgPath = '2';
                          bloodData[i].click = false;
                        }
                      }
                    } else {
                      bloodData[index].imgPath = '2';
                      bloodData[index].click = false;
                    }
                  });
                },
                child: myBloodCard(
                  imgPath: bloodData[index].imgPath,
                  bloodGroup: bloodData[index].bloodGroup,
                  bloodGroupInString: bloodData[index].bloodGroupInString,
                  selectedBorderColor: (bloodData[index].click)
                      ? Colors.blue
                      : Colors.pink.shade200,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Screen.deviceHeight / 17.45,
                width: Screen.deviceWidth / 1.96,
                decoration: BoxDecoration(
                  color: Colors.pink[400],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    "Select City :",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
              getCity()
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Screen.deviceHeight / 17.45,
                width: Screen.deviceWidth / 1.45,
                decoration: BoxDecoration(
                  color: Colors.pink[400],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    "Select Unit Of Blood :",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
              Card(
                elevation: 4,
                child: DropdownButton(
                  elevation: 3,
                  underline: Text(''),
                  value: selectedUnit,
                  items: unitOfBlood.map((value) {
                    return DropdownMenuItem(
                      child: myText(string: '  $value'),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Stack(
            // overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Container(
                height: Screen.deviceHeight / 5.24,
                width: Screen.deviceWidth,
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(120)),
                ),
              ),
              Positioned(
                bottom: Screen.deviceHeight / 8,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink[400],
                  child: Text(
                    "Emergency",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      for (int i = 0; i < bloodData.length; i++) {
                        if (bloodData[i].click == true) {
                          blood = bloodData[i].bloodGroup;
                        }
                      }
                    });
                    if (blood != null && selectedCity != null) {
                      print('send blood $blood and city $selectedCity');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendRequest(
                              passedBlood: blood!, passedCity: selectedCity!),
                        ),
                      );
                    } else {
                      print("blood or selectedCity is Null");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Row(
                            children: [
                              SizedBox(width: 10),
                              Text('Please Select Blood and City...')
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
