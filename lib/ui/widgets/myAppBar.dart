import 'package:flutter/material.dart';

PreferredSizeWidget myAppbar({
  Key? key,
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  double? elevation,
  bool? centerTitle = false,
  IconThemeData? iconTheme,
  double? leadingWidth,
  double? titleSpacing,
}) {
  return AppBar(
    key: key,
    title: title,
    leading: leading ??
        Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: elevation ?? 0,
    centerTitle: centerTitle,
    iconTheme: iconTheme,
    leadingWidth: leadingWidth,
  );
}
