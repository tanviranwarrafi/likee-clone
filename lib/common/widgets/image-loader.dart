import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class ImageLoader extends StatelessWidget {
  Color color;
  double size;
  ImageLoader({this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(
      color: color,
      size: size,
      duration: Duration(milliseconds: 1000),
    );
  }
}
