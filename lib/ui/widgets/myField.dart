import 'package:flutter/material.dart';

Widget myInputField({
  Key? key,
  required String labelText,
  required IconData icon,
  Widget? suffix,
  bool enabled = false,
  required TextEditingController controller,
  TextFormField? textFormField,
  required void Function(String) onChanged,
  void Function(String)? onFieldSubmitted,
  void Function()? onEditingComplete,
  void Function(String)? onSaved,
  bool obscureText = false,
  String? hintText,
  TextInputType? keyboardType,
}) {
  return Card(
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(
            icon,
            color: Colors.pink[300],
          ),
        ),
        RotatedBox(
          quarterTurns: 1,
          child: SizedBox(
            height: 30,
            width: 30,
            child: Divider(
              thickness: 2,
              color: Colors.black45,
            ),
          ),
        ),
        Expanded(
          child: textFormField ??
              TextFormField(
                obscureText: obscureText,
                // enabled: enabled,
                // onSaved: onSaved,
                keyboardType: keyboardType,
                onEditingComplete: onEditingComplete,
                controller: controller,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
                cursorColor: Colors.black45,
                decoration: InputDecoration(
                  hintText: hintText,
                  // enabled: enabled,
                  suffixIcon: suffix,
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: TextStyle(
                    color: Colors.black45,
                    // fontSize: 17,
                  ),
                ),
              ),
        ),
      ],
    ),
  );
}
