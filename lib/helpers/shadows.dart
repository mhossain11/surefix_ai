/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

class Shadows {
  static BoxShadow getShadow({required double spread, required double blur}) {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.4),
      spreadRadius: spread,
      blurRadius: blur,
      offset: Offset(0, 4), // changes position of shadow
    );
  }
}
