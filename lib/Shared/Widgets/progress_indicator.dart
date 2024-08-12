import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator(this.color,{super.key});

  final Color color;
  

  @override
  Widget build(BuildContext context) {
    Widget indicator = CircularProgressIndicator(color: color,);
    if (Platform.isIOS) {
      indicator = const CupertinoActivityIndicator();
    }
    return Center(
      child: indicator,
    );
  }

}