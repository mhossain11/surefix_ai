import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final bool obscureText;

  const ProfileField({ this.icon, required this.hintText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon)??SizedBox(),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}