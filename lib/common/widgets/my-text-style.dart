import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final inherit;
  final letterSpacing;
  final TextDecoration textDecoration;
  final FontStyle fontStyle;

  const MyTextStyle({
    @required this.color,
    @required this.fontWeight,
    this.fontSize = 14,
    this.fontFamily = 'Roboto-Regular',
    this.inherit = true,
    this.letterSpacing = 0,
    this.textDecoration = TextDecoration.none,
    this.fontStyle = FontStyle.normal,
  })  : assert(color != null && fontWeight != null),
        super(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: fontFamily,
        );
}
