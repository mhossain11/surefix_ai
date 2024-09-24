/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

const double _kMyLinearProgressIndicatorHeight = 4.0;

class MyLinearProgressIndicator extends LinearProgressIndicator
    implements PreferredSizeWidget {
  MyLinearProgressIndicator({
    required Key key,
    required double value,
    required Color backgroundColor,
    required Animation<Color> valueColor,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        ) {
    preferredSize = const Size(double.infinity, _kMyLinearProgressIndicatorHeight);
  }

  @override
 late Size preferredSize;
}
