import 'package:blood_Bank/ui/widgets/MyContainer.dart';
import 'package:blood_Bank/utils/Screen.dart';
import 'package:flutter/material.dart';

class DonorProfile extends StatelessWidget {
  final String? url, name, city, phoneNo;

  DonorProfile({
    this.url,
    this.name,
    this.city,
    this.phoneNo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return myContainer(
      height: Screen.deviceHeight * 0.5,
      width: Screen.deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              this.url.toString(),
            ),
          ),
          // Text('name $name'),
          Text(
            "Name : $name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "City : $city",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "MobileNo : $phoneNo",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
