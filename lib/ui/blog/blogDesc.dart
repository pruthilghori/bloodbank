import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/ui/widgets/myText.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogDesc extends StatefulWidget {
  final String id;

  BlogDesc({required this.id});

  @override
  _BlogDescState createState() => _BlogDescState();
}

class _BlogDescState extends State<BlogDesc> {
  @override
  Widget build(BuildContext context) {
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
        stream: FirebaseFirestore.instance
            .collection('blog')
            .doc(widget.id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: myText(
                        string: snapshot.data.data()['title'],
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontColor: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    myContainer(
                      containerBorder:
                          Border.all(color: Colors.black54, width: 1),
                      height: Screen.deviceHeight * 0.3,
                      width: Screen.deviceWidth * 0.9,
                      containerBorderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.network(
                          snapshot.data.data()['imgUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myText(
                        string: snapshot.data.data()['description'],
                        fontSize: 20,
                        textAlign: TextAlign.justify,
                        fontColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
