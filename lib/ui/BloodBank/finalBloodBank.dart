import 'package:auto_animated/auto_animated.dart';
import 'package:blood_Bank/ui/FindDonor/findDonor.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiBloodBank extends StatefulWidget {
  @override
  _UiBloodBankState createState() => _UiBloodBankState();
}

class _UiBloodBankState extends State<UiBloodBank> {
  final CallService _service = locator<CallService>();

  String? selectedCity;
  List<String> city = ["Surat", "Ahmadabad", "Vapi", "Rajkot"];

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('blood_bank');
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreen(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.pink[400],
        title: myText(
          string: 'List of Blood Bank',
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: Screen.deviceHeight,
            width: Screen.deviceWidth,
            color: Colors.pink[400],
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Screen.deviceHeight / 15.71,
                    width: Screen.deviceWidth / 1.2,
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Select City :",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.pink[300]),
                          ),
                          Card(
                            color: Colors.pink[50],
                            elevation: 5,
                            child: DropdownButton(
                              underline: Text(''),
                              elevation: 2,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: Screen.deviceHeight / 1.31,
            width: Screen.deviceWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 12),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('blood_bank')
                    .where('city', isEqualTo: selectedCity)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.data == null) {
                    return Center(child: Text("No data available"));
                  }
                  QuerySnapshot<Map<String, dynamic>> querySnapshot =
                      snapshot.data! as QuerySnapshot<Map<String, dynamic>>;
                  if (querySnapshot.docs.isEmpty) {
                    return Center(child: Text("No documents available"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    print('data ${querySnapshot.docs[0]['name']}');
                    return LiveList.options(
                      itemCount: querySnapshot.size,
                      controller: _scrollController,
                      options: LiveOptions(
                        delay: Duration.zero,
                        reAnimateOnVisibility: false,
                        showItemDuration: Duration(milliseconds: 500),
                        showItemInterval: Duration(milliseconds: 50),
                      ),
                      itemBuilder: (context, index, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(0, 0.3), end: Offset.zero)
                                .animate(animation),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                elevation: 5,
                                child: Container(
                                  width: Screen.deviceWidth * 0.9,
                                  height: 165,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(
                                        color: Colors.black54, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        myText(
                                            string: querySnapshot.docs[index]
                                                    ['name']
                                                .toString(),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                        Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              child: myText(
                                                string: querySnapshot
                                                    .docs[index]['address']
                                                    .toString(),
                                                fontSize: 14,
                                                fontColor: Colors.black54,
                                              ),
                                              width: Screen.deviceWidth * 0.9,
                                            ),
                                            myText(
                                              string:
                                                  '${querySnapshot.docs[index]['area'].toString()}, ${querySnapshot.docs[index]['city'].toString()}.',
                                              fontSize: 14,
                                              fontColor: Colors.black54,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            myText(
                                              string: querySnapshot.docs[index]
                                                      ['mobile']
                                                  .toString(),
                                              fontSize: 20,
                                              fontColor: Colors.blue[400],
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                CupertinoIcons
                                                    .phone_circle_fill,
                                                size: 35,
                                                color: Colors.blue[400],
                                              ),
                                              onPressed: () => _service.call(
                                                  querySnapshot.docs[index]
                                                      ['mobile']),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
