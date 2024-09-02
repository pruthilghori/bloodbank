import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  double _rating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Bank Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Rate your experience:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Column(
              children: [
                // RatingBar.builder(
                //   initialRating: _rating,
                //   minRating: 0,
                //   direction: Axis.horizontal,
                //   allowHalfRating: true,
                //   itemCount: 5,
                //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                //   itemBuilder: (context, _) => Icon(
                //     Icons.star,
                //     color: Colors.amber,
                //   ),
                //   onRatingUpdate: (rating) {
                //     setState(() {
                //       _rating = rating;
                //     });
                //   },
                // ),
                EmojiFeedback(
                  onChanged: (index) {
                    setState(() {
                      _rating = index + 0;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  "$_rating",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _email,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.text,
              maxLines: null,
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Feedback',
                hintText: 'Feedback',
                prefixIcon: Icon(Icons.feedback_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () async {
                  String feedbackText = _feedbackController.text.trim();
                  String emailText = _email.text.trim();
                  if (feedbackText.isNotEmpty) {
                    //store
                    await FirebaseFirestore.instance
                        .collection("feedback")
                        .add({
                      'rating': _rating,
                      'email': emailText,
                      'feedback': feedbackText,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    _feedbackController.clear();
                    _email.clear();
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Feedback Submitted SuccessFully!")));
                  }
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
