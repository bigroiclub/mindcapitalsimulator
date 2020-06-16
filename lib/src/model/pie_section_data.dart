import 'package:flutter/material.dart';

class PieSectionData {
  String title;
  Color color;
  double value;
  bool isTouched = false;

  PieSectionData({@required this.title, @required this.value, @required this.color});
  
}