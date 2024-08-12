import 'package:flutter/material.dart';

class AppNavigator {

  static void push(Widget screen, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }

  static void pushReplacement(Widget screen, BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pushAndRemoveUntil(Widget screen, BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contex) => screen), (route) => false);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

}
