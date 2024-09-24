import 'dart:math';

import 'package:flutter/material.dart';

class PopupIcon extends StatelessWidget {
  final Widget? icon;
  final Color? color;
  final String text;

   PopupIcon({
    super.key,
     this.icon,
     this.color,
    required this.text,
  });


  bool onIt = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      content: Text(text),
      backgroundColor: color,
    );

  }
}