/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

import '../utils/colors.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final FocusNode? nextNode;
  final String? hint;
  final String? label;
  final double? borderRadius;
  final String? Function(String?) validators;
  final IconData? prefixIcon;
  final String? prefixText;
  final Widget? suffix;
  final String? hasBorder;
  final bool? obscure;
  final int? maxLengths;

  CustomTextField(
      {required this.validators,
      required this.controller,
       this.focusNode,
       this.suffix,
       this.obscure,
       this.hasBorder,
       this.textInputType,
        required this.nextNode,
       this.hint,
       this.label,
       this.maxLengths,
       this.borderRadius,
      this.prefixText,
       this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      cursorColor: colorTheme,
      obscureText: obscure ?? false,
      onEditingComplete: () {
      FocusScope.of(context).requestFocus(nextNode);
    },
      maxLength: maxLengths ?? 120,
      decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.all(suffix == null ? 18 : 14),
          hintText: hint,
          labelText: label,
          prefixStyle: const TextStyle(color: blackLight, fontSize: 16),
          prefixText: prefixText == null ? null : prefixText,
          prefixIcon: prefixIcon == null
              ? null
              : Icon(
                  prefixIcon,
                  color: colorTheme.withOpacity(.7),
                ),
          fillColor: white,
          filled: true,
          labelStyle:
              const TextStyle(color: colorSubtitle, fontWeight: FontWeight.w300),
          hintStyle: TextStyle(
              color: colorSubtitle.withOpacity(.5),
              fontWeight: FontWeight.w300),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: hasBorder != null ? colorSubtitle : white,
              style: hasBorder != null ? BorderStyle.solid : BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          suffix: suffix,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: colorThemeLight,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: hasBorder != null ? colorSubtitle.withOpacity(.3) : white,
              style: hasBorder != null ? BorderStyle.solid : BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color: hasBorder != null ? colorSubtitle.withOpacity(.3) : white,
              style: hasBorder != null ? BorderStyle.solid : BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          )),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: validators ,
    );
  }
}
