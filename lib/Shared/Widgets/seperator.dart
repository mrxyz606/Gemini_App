import 'package:flutter/material.dart';
import 'package:gemini_app/Shared/Constants/dimenstions.dart';

Widget hSeperator({double leftMargin = 15}) {
  return Container(
    height: 2,
    width: screen_width - 10,
    margin: EdgeInsets.only(left: leftMargin, top: 4, bottom: 4),
    color: Colors.grey,
  );
}