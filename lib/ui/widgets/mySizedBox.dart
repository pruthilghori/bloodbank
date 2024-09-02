import 'package:flutter/cupertino.dart';

Widget mySizedBox({
  Key? key,
  Widget? child,
  double? height,
  double? width,
}) {
  return SizedBox(
    key: key,
    child: child,
    height: height,
    width: width,
  );
}
