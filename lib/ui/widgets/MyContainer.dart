import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myContainer({
  Key? key,
  required Widget child,
  double? height,
  double? width,
  AlignmentGeometry? alignment,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? containerColor,
  BoxBorder? containerBorder,
  BorderRadiusGeometry? containerBorderRadius,
  List<BoxShadow>? containerBoxShadow,
  Gradient? containerGradient,
  BlendMode? containerBgBlendMode,
  BoxShape? containerShape,
  ImageProvider? containerImage,
  BoxFit? containerImageFit,
  ColorFilter? containerImageColorFilter,
}) =>
    Container(
      // key: key,
      // assert(child != null), //check for it is null or not

      child: child,
      height: height,
      width: width,
      alignment: alignment,
      margin: margin,
      padding: padding,
      // clipBehavior: clipBehavior,
      // constraints: constraints,

      decoration: BoxDecoration(
        color: containerColor,
        border: containerBorder,
        borderRadius: containerBorderRadius,
        boxShadow: containerBoxShadow,
        gradient: containerGradient,
        backgroundBlendMode: containerBgBlendMode,
        // shape: (containerShape != null) ? containerShape : null,
        image: (containerImage != null)
            ? DecorationImage(
                image: containerImage,
                fit: containerImageFit,
                colorFilter: containerImageColorFilter,
              )
            : null,
      ),
    );

//uses
//1)@required
//2)assert(condition,msg);
//3)use default value and named parameter

class ProjectItem {
  ProjectItem({@required data}) {
    assert(!(data.contians(null)), "please enter data");
  }
}

ProjectItem test = new ProjectItem(data: null);
