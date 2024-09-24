/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'ProjectResource.dart';
class ElevatedButtons extends StatelessWidget{
  final VoidCallback onPressed;
  final Widget child;
  final OutlinedBorder? shape;
  final Size? fixedSize;
  final BorderSide? side;
  final Color? backgroundColor;
  const ElevatedButtons({super.key, required this.onPressed,
    required this.child, this.shape, this.fixedSize, this.side,
    this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: shape,
            fixedSize: fixedSize,
            side: side,
            backgroundColor: backgroundColor
        ),
        child: child);
  }

}
class WCMaterialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final double? sides;

  const WCMaterialButton(
      {super.key, required this.onPressed,
      required this.child,
       this.width,
       this.height,
       this.color, this.sides});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: width,
      height: height,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 0)?? BorderSide(width: sides!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorBrightness: Brightness.light,
      disabledColor: Colors.black26,
      child: child,
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double? elevation;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? borderColor;

  CustomButton(
      {required this.onPressed,
      required this.child,
       this.width,
       this.elevation,
       this.height,
       this.color,
       this.borderColor,
       this.radius});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: color ?? colorTheme,
      height: height ?? ProjectResource.screenHeight * .055,
      minWidth: width ?? ProjectResource.screenWidth,

      child: MaterialButton(
        elevation: elevation,
        color: color ?? colorTheme,
        disabledColor: color ?? colorTheme,
        disabledElevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 10))),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class ProductButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double? elevation;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? borderColor;

  ProductButton(
      {required this.onPressed,
      required this.child,
       this.width,
       this.elevation,
      this.height,
       this.color,
       this.borderColor,
       this.radius});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: color ?? colorTheme,
      height: height ?? ProjectResource.screenHeight * .065,
      minWidth: width ?? ProjectResource.screenWidth,
      child: MaterialButton(
        elevation: elevation,
        color: color ?? Colors.black,
        disabledColor: color ?? Colors.black,
        disabledElevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius ?? 10),
          bottomRight: Radius.circular(radius ?? 10),
        )),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
