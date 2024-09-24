/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/rendering.dart';

class Gradients {
  static LinearGradient linearGradients(
      {required Color first,
      required Color second,
      required AlignmentGeometry begins,
      required AlignmentGeometry ends,
      required TileMode tileMode}) {
    return LinearGradient(
        colors: [
          first,
          second,
        ],
        begin: begins ?? Alignment.centerRight,
        end: ends ?? Alignment.center,
        tileMode: tileMode ?? TileMode.mirror);
  }
}
