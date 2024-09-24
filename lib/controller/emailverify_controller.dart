/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/ProjectResource.dart';
import '../helpers/snackbars.dart';
import '../services/shared_preference.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../views/Auth/passwordRecovery/pincode_verify_screen.dart';
import '../views/Dashboard/dashboard.dart';
// import 'package:surefix_ai/models/jsonModel/userModel.dart';

class EmailVerifyController extends ChangeNotifier {
  bool loading = false;
  bool loadingError = false;
  bool passwordVisible = true;
  TextEditingController emailController = TextEditingController();
  FocusNode emailControllerNode = FocusNode();
  late String token;
  String? message;
  String? usertype;
  static String loginUserEmail="";

  passVisibleChange() {
    passwordVisible = !passwordVisible;
    print(passwordVisible);
    notifyListeners();
  }

  clear() {
    emailController.clear();
  }


  emailSend({context}) async {
    loading = true;
    notifyListeners();
    print(emailController.text.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailReset', emailController.text.toString());
    var response = await http.post(Uri.parse(ApiEnd.emailVerifyPostUrl),
        body: {
          "email": emailController.text,
        });
    print(response.statusCode);
    if (response.statusCode == 200) {

      loading = false;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PinCodeVerifyScreen()));
    } else {
      notifyListeners();
      loading = false;
      SnackBars.showSnackBar(
          context: context,
          content: "Incorrect Email, Please check again!!!",
          durationSec: 3,
          success: false,
          routeAction: null);
    }
    notifyListeners();
  }
}
