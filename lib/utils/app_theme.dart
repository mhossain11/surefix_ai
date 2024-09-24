/*
 *
 *  @author  Md. Rukunujjaman Miaji
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';
import 'package:surefix_ai/utils/colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: colorTheme,
  primarySwatch: kPrimaryColor,
  scaffoldBackgroundColor: white,
  primaryColorDark: black.withOpacity(.1),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  appBarTheme:
      const AppBarTheme(color: white, iconTheme: IconThemeData(color: Colors.black)),
);
