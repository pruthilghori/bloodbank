import 'package:auto_animated/auto_animated.dart';
import 'package:blood_Bank/ui/FindDonor/donorProfile.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class CallService {
  void call(String number) => launch("tel:$number");
}

GetIt locator = GetIt.asNewInstance();

void set() {
  locator.registerSingleton(CallService());
}

GlobalKey<ScaffoldState> findDonorScaffoldKey = new GlobalKey<ScaffoldState>();

class UiFindDonor extends StatefulWidget {
  @override
  _UiFindDonorState createState() => _UiFindDonorState();
}

class _UiFindDonorState extends State<UiFindDonor> {
  CollectionReference query =
      FirebaseFirestore.instance.collection("Registration");

  final CallService _service = locator<CallService>();

  // Future getPosts() async {
  //   // var firestore = FirebaseFirestore.instance;
  //   Stream<QuerySnapshot> qn = query.snapshots();
  // }

  //Stream<QuerySnapshot> qn = query.snapshots();

  TextEditingController searchController = TextEditingController();
  TextEditingController cityController = TextEditingController();

// User user;
  List<String> bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  final firebaseReference = FirebaseDatabase.instance.ref();
  final db = FirebaseDatabase.instance.ref();
  DatabaseReference? databaseReference;
  String? selectedBloodGroup;
  String? selectedCity;
  List<String> city = [
    "Surat",
    "Baroda",
    "Ahmedabad",
    "Vapi",
    "Rajkot",
    "Bhavanagar",
  ];
  List<QueryDocumentSnapshot> list = [];
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
    return Scaffold(
        key: findDonorScaffoldKey,
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Stack(
            // overflow: Overflow.visible,
            children: [
              Positioned(
                right: 0,
                child: Container(
                  height: Screen.deviceHeight,
                  width: 130,
                  color: Colors.pink[300],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: myText(
                      string: 'Find Donor',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Screen.deviceHeight / 15.71,
                        width: Screen.deviceWidth / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(25)),
                        ),
                        child: Center(
                          child: Text(
                            "Select BloodGroup :",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        margin: EdgeInsets.only(right: 8),
                        child: DropdownButton(
                          underline: Text(''),
                          elevation: 1,
                          value: selectedBloodGroup,
                          items: bloodGroup.map((value) {
                            return DropdownMenuItem(
                              child: myText(string: value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBloodGroup = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Screen.deviceHeight / 15.71,
                        width: Screen.deviceWidth / 1.96,
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(25)),
                        ),
                        child: Center(
                          child: Text(
                            "     Select City :",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        margin: EdgeInsets.only(right: 8),
                        child: DropdownButton(
                          underline: Text(''),
                          elevation: 1,
                          value: selectedCity,
                          items: city.map((value) {
                            return DropdownMenuItem(
                              child: myText(string: value),
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
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: (selectedBloodGroup == null ||
                              selectedCity == null)
                          ? query.snapshots()
                              as Stream<QuerySnapshot<Map<String, dynamic>>>?
                          : query
                                  .where('BloodGroup',
                                      isEqualTo: selectedBloodGroup)
                                  .where('City', isEqualTo: selectedCity)
                                  .snapshots()
                              as Stream<
                                  QuerySnapshot<
                                      Map<String,
                                          dynamic>>>?, // Use snapshots() instead of get().asStream()
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("No Data Available"));
                        }

                        QuerySnapshot<Map<String, dynamic>> querySnapshot =
                            snapshot.data!;

                        return LiveList.options(
                          itemCount: querySnapshot.size,
                          options: LiveOptions(
                            delay: Duration.zero,
                            reAnimateOnVisibility: false,
                            showItemDuration: Duration(milliseconds: 500),
                            showItemInterval: Duration(milliseconds: 50),
                          ),
                          controller: _scrollController,
                          itemBuilder: (context, index, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(0, 0.3), end: Offset.zero)
                                    .animate(animation),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      // overflow: Overflow.visible,
                                      alignment: Alignment.center,
                                      children: [
                                        Center(
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 3,
                                            color: Colors.blueGrey[50],
                                            child: Container(
                                              height: 80,
                                              width: Screen.deviceWidth / 1.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blueGrey[50],
                                              ),
                                              child: ListTile(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    context: context,
                                                    builder: (context) {
                                                      return DonorProfile(
                                                        name: querySnapshot
                                                                .docs[index]
                                                            ['Name'],
                                                        city: querySnapshot
                                                                .docs[index]
                                                            ['City'],
                                                        phoneNo: querySnapshot
                                                                .docs[index]
                                                            ['MobileNo'],
                                                        url: querySnapshot
                                                                .docs[index]
                                                            ['imageUrl'],
                                                      );
                                                    },
                                                  );
                                                },
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 40,
                                                  ),
                                                  child: Text(
                                                    querySnapshot.docs[index]
                                                        ["Name"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 40,
                                                  ),
                                                  child: Text(
                                                      querySnapshot.docs[index]
                                                              ['City'] ??
                                                          'null',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 16,
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      CupertinoIcons.phone_fill,
                                                      color: Colors.green,
                                                      size: 30,
                                                    ),
                                                    onPressed: () => _service
                                                        .call(querySnapshot
                                                                .docs[index]
                                                            ["MobileNo"]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: -1,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: (querySnapshot
                                                            .docs[index]
                                                        ["imageUrl"] ==
                                                    "")
                                                ? AssetImage(
                                                        "assets/images/Profile/pro.png")
                                                    as ImageProvider<Object>?
                                                : NetworkImage(querySnapshot
                                                    .docs[index]["imageUrl"]),
                                          ),
                                        ),
                                        Positioned(
                                          right: 1,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Colors.blueGrey[200],
                                            radius: 20,
                                            child: Text(
                                                querySnapshot.docs[index]
                                                            ['BloodGroup'] !=
                                                        null
                                                    ? querySnapshot.docs[index]
                                                        ['BloodGroup']
                                                    : 'Unknown',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // : Expanded(
                  //     child: ListView.builder(
                  //       itemCount: list.length,
                  //       itemBuilder: (context, index) {
                  //         return ListTile(
                  //           title: Text(list[index]['Name']),
                  //           subtitle: Text(list[index]['City']),
                  //           trailing: Text(list[index]['BloodGroup']),
                  //         );
                  //       },
                  //     ),
                  //   )

// child: ListView.builder(
//   itemCount: listUser.length,
//   itemBuilder: (context, index) =>Card(
//     child: ListTile(
//       leading: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Name:${listUser[index].name}"),
//           Text("City:${listUser[index].city}"),
//         ],
//       ),
//       trailing: Text(listUser[index].bloodGroup),
//     ),
//   ),
// ),
// ),
//     :Expanded(
//   child: ListView.builder(
//     itemCount: listData.length,
//     itemBuilder: (context, index) =>Card(
//       child: ListTile(
//         leading: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Name:${listData[index].name}"),
//             Text("City:${listData[index].city}"),
//           ],
//         ),
//         trailing: Text(listData[index].bloodGroup),
//       ),
//     ),
//   ),
// ),
                ],
              ),
            ],
          ),
        ));
  }
}

// class User {
//   String name;
//   String bloodGroup;
//   String city;
//  // String city;
//   String key;
//
//   User({this.name, this.bloodGroup, this.city, this.key});
//
//   User.forSnapshot(DataSnapshot snapshot)
//       : key = snapshot.key,
//         name = snapshot.value["Name"],
//         bloodGroup = snapshot.value["BloodGroup"],
//         city = snapshot.value["City"];
//       //  city = snapshot.value["City"];
//
//   toJson() {
//     return {
//       "Name": name,
//       "BloodGroup": bloodGroup,
//       "City": city,
//     // "City":city,
//     };
//   }
// }

//

//changed code

//  Expanded(
//                     child: StreamBuilder(
//                       stream: query
//                           .where('BloodGroup', isEqualTo: selectedBloodGroup)
//                           .where('City', isEqualTo: selectedCity)
//                           .get()
//                           .asStream(),
//                       builder: (context, stream) {
//                         if (stream.connectionState == ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         }

//                         if (stream.hasError) {
//                           return Center(child: Text(stream.error.toString()));
//                         }
//                         QuerySnapshot<Map<String, dynamic>> querySnapshot =
//                             stream.data as QuerySnapshot<Map<String, dynamic>>;
//                         return LiveList.options(
//                           itemCount: querySnapshot.size,
//                           options: LiveOptions(
//                             delay: Duration.zero,
//                             reAnimateOnVisibility: false,
//                             showItemDuration: Duration(milliseconds: 500),
//                             showItemInterval: Duration(milliseconds: 50),
//                           ),
