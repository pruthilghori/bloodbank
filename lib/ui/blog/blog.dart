import 'package:auto_animated/auto_animated.dart';
import 'package:blood_Bank/ui/blog/blogDesc.dart';
import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum blogState { Blog, BlogDesc }

class UiBlog extends StatefulWidget {
  @override
  _UiBlogState createState() => _UiBlogState();
}

class _UiBlogState extends State<UiBlog> {
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
          string: 'Blog',
          fontColor: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blog').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            return Center(child: Text("No data available"));
          } else {
            QuerySnapshot querySnapshot = snapshot.data!;
            return LiveList.options(
              padding: EdgeInsets.all(10),
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
                    position:
                        Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
                            .animate(animation),
                    child: InkWell(
                      onTap: () {
                        print('id ${querySnapshot.docs[index].id}');
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                BlogDesc(id: querySnapshot.docs[index].id),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(12),
                          child: myContainer(
                            height: 340,
                            containerColor: Colors.white,
                            containerBorderRadius: BorderRadius.circular(12),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myContainer(
                                    containerBorder: Border.all(
                                        color: Colors.black54, width: 1),
                                    height: Screen.deviceHeight * 0.3,
                                    width: Screen.deviceWidth * 0.9,
                                    containerBorderRadius:
                                        BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Image.network(
                                        querySnapshot.docs[index]['imgUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                myText(
                                  string: querySnapshot.docs[index]['title'],
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontColor: Colors.black54,
                                ),
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
    );
  }
}
